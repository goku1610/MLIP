import pandas as pd
import numpy as np
import ast
import os
import argparse
import sys
# from dotenv import load_dotenv

# Load environment variables from .env file
# load_dotenv()

#conversion constants
st = 0.006241509 # conversion factor from kbar to eV/angstrom^3
fo = 51.421 # conversion factor from Ry/au to eV/angstrom

def parse_arguments():
    """Parse command line arguments for input and output file paths."""
    parser = argparse.ArgumentParser(description='Process QE output file and extract data.')
    
    # Required argument for input file
    parser.add_argument('-i', '--input', 
                        default=os.getenv('CSV_DEFAULT_INPUT', 'W_bomd_500_supercell.csv'),
                        help='Path to the input QE output file')
    
    # Optional argument for output file (defaults to input filename with .cfg extension)
    parser.add_argument('-o', '--output', 
                        help='Path for the output CFG file (default: input_filename.cfg)')
    
    parser.add_argument('-m', '--mode',
                        default='w',
                        help='Mode of writing: "a" for append, "w" for overwrite (default: w)')
    
    # Optional arguments for selecting a range of rows
    parser.add_argument('--start', type=int, default=0,
                        help='Starting index of rows to consider (default: 0)')
    parser.add_argument('--end', type=int, default=None,
                        help='Ending index of rows to consider (default: None, meaning all rows)')

    # Parse the arguments 
    args = parser.parse_args()
    
    # If output path is not specified, create default based on input filename
    if args.output is None:
        input_basename = os.path.splitext(os.path.basename(args.input))[0]
        args.output = f"{input_basename}.cfg"
    
    return args

def create_cfg_file(df, filename, mode):
    with open(filename, mode) as f:
        for _, row in df.iterrows():
            f.write('BEGIN_CFG\n')

            f.write(' Size\n')
            natoms = row['number_of_atoms']
            f.write(f'  {natoms}\n')  

            f.write(' Supercell\n')
            a1 = ast.literal_eval(row['cell_a'])
            a2 = ast.literal_eval(row['cell_b'])
            a3 = ast.literal_eval(row['cell_c'])
            volume = float(a1[0])*float(a2[1])*float(a3[2])
            f.write(f'  {float(a1[0])}  {float(a1[1])}  {float(a1[2])}\n')
            f.write(f'  {float(a2[0])}  {float(a2[1])}  {float(a2[2])}\n')
            f.write(f'  {float(a3[0])}  {float(a3[1])}  {float(a3[2])}\n')
            # already in angstorms

            f.write(' AtomData:  id type     cartes_x       cartes_y        cartes_z            fx          fy          fz\n')
            for i in range(natoms):
                coord_data = ast.literal_eval(row[f'cart_pos_{i}'])
                force_data = ast.literal_eval(row[f'force_{i}'])
                f.write(f'  {i+1}    {str(int(force_data[0])-1)}       {coord_data[1]}      {coord_data[2]}      {coord_data[3]}    {float(force_data[1])*fo}    {float(force_data[2])*fo}    {float(force_data[3])*fo}\n')
            # force in eV/angstrom

            f.write(f" Energy\n  {float(row['total_energy'])*13.6}\n") # rydberg to eV conversion

            f.write(' PlusStress:  xx          yy          zz          yz          xz          xy\n')
            tensor_row_1 = ast.literal_eval(row["stress_xx"])
            tensor_row_2 = ast.literal_eval(row["stress_yy"])
            tensor_row_3 = ast.literal_eval(row["stress_zz"])
            xx, yy, zz, yz, xz, xy = tensor_row_1[0], tensor_row_2[1], tensor_row_3[2], tensor_row_2[2], tensor_row_1[2], tensor_row_1[1]
            f.write(f"  {volume*st*xx}    {volume*st*yy}    {volume*st*zz}    {volume*st*yz}    {volume*st*xz}    {volume*st*xy}\n")
            # kbar to eV conversion and multiplied by cell volume in angstroms^3

            f.write('END_CFG')
            f.write('\n\n')
    f.close()

def main():
    args = parse_arguments()
    
    # Check if input file exists
    if not os.path.isfile(args.input):
        print(f"Error: Input file '{args.input}' does not exist.")
        sys.exit(1)

    if type(args.mode) != str and args.mode not in ['a', 'w']:
        print(f"Error: Mode '{args.mode}' cannot be implemented")
        sys.exit(1)
    
    print(f"Processing input file: {args.input}")
    if args.mode == 'a':
        print(f"Output will be appended to: {args.output}")
    if args.mode == 'w':
        print(f"Output will be overwritten to: {args.output}")

    # Load the data from the CSV file
    df = pd.read_csv(args.input)

    # Remove rows with NaN values
    initial_row_count = len(df)
    df = df.dropna()
    final_row_count = len(df)

    if initial_row_count > final_row_count:
        print(f"Removed {initial_row_count - final_row_count} rows with NaN values.")

    # Filter rows based on the start and end indices
    df = df.iloc[args.start:args.end]
    print(f"Selected rows from index {args.start} to {args.end if args.end else 'end'}.")

    # Create the CFG file
    create_cfg_file(df, args.output, args.mode)
    print(f"Data extracted and saved to {args.output}")

if __name__ == "__main__":
    main()
