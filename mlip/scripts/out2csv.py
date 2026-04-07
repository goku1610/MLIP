import re
import numpy as np
import pandas as pd
import os
import argparse
import sys
# from dotenv import load_dotenv

# Load environment variables from .env file
# load_dotenv()

def parse_arguments():
    """Parse command line arguments for input and output file paths."""
    parser = argparse.ArgumentParser(description='Process QE output file and extract data.')
    
    # Required argument for input file
    parser.add_argument('-i', '--input', 
                        default=os.getenv('OUT_DEFAULT_INPUT', ''),
                        help='Path to the input QE output file')
    
    # Optional argument for output file (defaults to input filename with .csv extension)
    parser.add_argument('-o', '--output', 
                        help='Path for the output CSV file (default: input_filename.csv)')
    
    # Parse the arguments
    args = parser.parse_args()
    
    # If output path is not specified, create default based on input filename
    if args.output is None:
        input_basename = os.path.splitext(os.path.basename(args.input))[0]
        args.output = f"{input_basename}.csv"
    
    return args


def parse_qe_output(filename):
    with open(filename, 'r') as f:
        content = f.read()

    data = []
    iterations = re.split(r'Self-consistent Calculation', content)
    ini_data = iterations[0]
    iterations = iterations[1:]
    print("The number of iterations in the simulation : ", len(iterations), "\n")
    
    natoms_raw = re.search(r'number of atoms/cell\s+=\s+(\d+)', ini_data)
    natoms = int(natoms_raw.group(1)) if natoms_raw else None
    for i in range(0, len(iterations)):
        it_num = i + 1
        it_content = iterations[i] 
        it_data = {'iteration': it_num}
        it_data['number_of_atoms'] = natoms

        # Extract time
        time_match = re.search(r'time =\s+([\d.]+)\s+pico-seconds', it_content)
        it_data['time'] = float(time_match.group(1)) if time_match else 0.0
        
        # Extract total energy
        energy_match = re.search(r'!    total energy\s+=\s+([\d.-]+)\s+Ry', it_content)
        it_data['total_energy'] = float(energy_match.group(1)) if energy_match else None
        
        # Extract forces
        forces = []
        force_section = re.search(r'Forces acting on atoms.*\n(.*?)\n\s*The non-local contrib', it_content, re.DOTALL)
        if force_section:
            for line in force_section.group(0).split('\n'):
                if line.strip().startswith('atom'):
                    parts = line.split('=')[1].strip().split()
                    atom_type = line.split('=')[0].split()[3]
                    forces.append([atom_type] + [float(x) for x in parts])
        it_data['forces'] = forces

        # Extract stress
        stress_pattern = r'total\s+stress\s+\(Ry/bohr\*\*3\)\s+\(kbar\)\s+P=\s+[-\d.]+\n((?:\s+[-\d.eE]+\s+[-\d.eE]+\s+[-\d.eE]+\s+[-\d.eE]+\s+[-\d.eE]+\s+[-\d.eE]+\n){3})'
        stress_match = re.search(stress_pattern, it_content, re.DOTALL)

        if stress_match:
            # Extract the three lines containing stress values
            stress_block = stress_match.group(1).strip().split('\n')
            stress_tensor = []
            for line in stress_block:
                values = line.split()
                # Get the last three values which are the kbar components
                kbar_values = [float(values[-3]), float(values[-2]), float(values[-1])]
                stress_tensor.append(kbar_values)
            it_data['stress'] = stress_tensor
            # print(f"Stress tensor for iteration {it_num}: {stress_tensor}")
        else:
            print(f"Warning: Stress data not found for iteration {it_num}.")
            it_data['stress'] = None
        
        # Extract Ekin and Etot
        ekin_match = re.search(r'Ekin\s+=\s+([\d.]+)\s+Ry', it_content)
        etot_match = re.search(r'Etot\s+=\s+([\d.-]+)', it_content)
        it_data['Ekin'] = float(ekin_match.group(1)) if ekin_match else None
        it_data['Etot'] = float(etot_match.group(1)) if etot_match else None
        
        # Extract cell parameters
        cell_params = []
        cell_section = re.search(r'CELL_PARAMETERS \(angstrom\)(.*?)\n\n', it_content, re.DOTALL)
        if cell_section:
            for line in cell_section.group(1).split('\n'):
                if line.strip():
                    cell_params.append([float(x) for x in line.split()])
        it_data['cell_parameters'] = cell_params
        
        # Extract atomic positions
        atomic_pos = []
        pos_section = re.search(r'ATOMIC_POSITIONS \(crystal\)(.*?)\n\n', it_content, re.DOTALL)
        if pos_section:
            for line in pos_section.group(1).split('\n'):
                if line.strip():
                    parts = line.split()
                    atomic_pos.append([parts[0]] + [float(x) for x in parts[1:4]])
        it_data['atomic_positions'] = atomic_pos
        
        # Calculate Cartesian coordinates
        if cell_params and atomic_pos:
            cell_matrix = np.array(cell_params)
            cart_pos = []
            for atom in atomic_pos:
                cryst_coord = np.array(atom[1:4])
                cart_coord = np.dot(cryst_coord, cell_matrix)
                cart_pos.append([atom[0]] + cart_coord.tolist())
            it_data['cartesian_positions'] = cart_pos
        
        data.append(it_data)
    
    return data

def main():
    args = parse_arguments()
    
    # Check if input file exists
    if not os.path.isfile(args.input):
        print(f"Error: Input file '{args.input}' does not exist.")
        sys.exit(1)
    
    print(f"Processing input file: {args.input}")
    print(f"Output will be saved to: {args.output}")

    # args.input = r"C:\Users\prudh\Downloads\bomd_500K\bomd_500K\W_bomd_500_supercell.out"

    # Parse the file
    output_data = parse_qe_output(args.input)

    # Convert to pandas DataFrame
    df = pd.DataFrame(output_data)

    # Count and remove rows with None stress values
    initial_rows = len(df)
    df = df[df['stress'].notna()]
    rows_removed = initial_rows - len(df)
    print(f"\nRemoved {rows_removed} rows with missing stress data")
    print(f"Remaining rows: {len(df)}\n")

    # Expand nested lists into separate columns
    df = pd.concat([
        df.drop(['forces', 'stress', 'cell_parameters', 'atomic_positions', 'cartesian_positions'], axis=1),
        df['forces'].apply(pd.Series).add_prefix('force_'),
        pd.DataFrame(df['stress'].tolist(), columns=['stress_xx', 'stress_yy', 'stress_zz']),
        pd.DataFrame(df['cell_parameters'].tolist(), columns=['cell_a', 'cell_b', 'cell_c']),
        df['atomic_positions'].apply(pd.Series).add_prefix('atom_pos_'),
        df['cartesian_positions'].apply(pd.Series).add_prefix('cart_pos_')
    ], axis=1)

    num_columns = len(df.columns)
    column_names = df.columns.tolist()
    num_rows = len(df)
    missing_values = df.isnull().sum().sum()
    data_types = df.dtypes

    print("Number of columns:", num_columns)
    print("Column names:", column_names)
    print("Number of rows:", num_rows)
    print("Number of missing values:", missing_values)
    print("\nData types:")
    print(data_types)
    print("\nSummary statistics:")
    print(df.describe())

    # Save to CSV
    df.to_csv(args.output, index=False)

    print(f"Data extracted and saved to {args.output}")

if __name__ == "__main__":
    main()