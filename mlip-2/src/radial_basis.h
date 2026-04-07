/*   This software is called MLIP for Machine Learning Interatomic Potentials.
 *   MLIP can only be used for non-commercial research and cannot be re-distributed.
 *   The use of MLIP must be acknowledged by citing approriate references.
 *   See the LICENSE file for details.
 *
 *   This file contributors: Alexander Shapeev, Evgeny Podryabinkin, Konstantin Gubaev
 */

#ifndef MLIP_RADIAL_BASIS_H
#define MLIP_RADIAL_BASIS_H

#include "mlip.h"
#include <array>

class AnyRadialBasis
{	
public:
	int rb_size;

	double min_dist;
	double max_dist;
	double scaling = 1.0; // all functions are multiplied by scaling 

	// values and derivatives, set by calc(r)
	std::vector<double> rb_vals;
	std::vector<double> rb_ders;

	virtual std::string GetRBTypeString()
	{
		return "RBAny";
	}

	virtual void ReadRadialBasis(std::ifstream& ifs);
	virtual void WriteRadialBasis(std::ofstream& ofs);

	AnyRadialBasis(double _min_dist, double _max_dist, int _size);
	AnyRadialBasis(std::ifstream& ifs);
	virtual ~AnyRadialBasis() {};
	
	virtual void RB_Calc(double r) = 0;	// calculates values and derivatives
	virtual void RB_Calc(double r, int i, int j) {RB_Calc(r);}
};



class RadialBasis_Shapeev : public AnyRadialBasis
{
private:
	static const int ALLOCATED_DEGREE = 11;
	double rb_coeffs[ALLOCATED_DEGREE + 1][ALLOCATED_DEGREE + 3];
	void InitShapeevRB();
	
public:	
	std::string GetRBTypeString() override
	{
		return "RBShapeev";
	}

	RadialBasis_Shapeev(double _min_dist, double _max_dist, int _size);
	RadialBasis_Shapeev(std::ifstream& ifs);

	void RB_Calc(double r);
	void RB_Calc(double r, int i, int j) {RB_Calc(r);}
};



class RadialBasis_Chebyshev : public AnyRadialBasis
{
public:
	std::string GetRBTypeString() override
	{
		return "RBChebyshev";
	}

	RadialBasis_Chebyshev(double _min_dist, double _max_dist, int _size)
		: AnyRadialBasis(_min_dist, _max_dist, _size) {};
	RadialBasis_Chebyshev(std::ifstream& ifs)
		: AnyRadialBasis(ifs) {};

	void RB_Calc(double r);
	void RB_Calc(double r, int i, int j) {RB_Calc(r);}
};



class RadialBasis_Chebyshev_repuls : public AnyRadialBasis
{
public:
	std::string GetRBTypeString() override
	{
		return "RBChebyshev_repuls";
	}

	RadialBasis_Chebyshev_repuls(double _min_dist, double _max_dist, int _size)
		: AnyRadialBasis(_min_dist, _max_dist, _size) {};
	RadialBasis_Chebyshev_repuls(std::ifstream& ifs)
		: AnyRadialBasis(ifs) {};

	void RB_Calc(double r);
	void RB_Calc(double r, int i, int j) {RB_Calc(r);}
};



class RadialBasis_Taylor : public AnyRadialBasis
{
public:	
	std::string GetRBTypeString() override
	{
		return "RBTaylor";
	}

	RadialBasis_Taylor(double _min_dist, double _max_dist, int _size)
		: AnyRadialBasis(_min_dist, _max_dist, _size) {};
	RadialBasis_Taylor(std::ifstream& ifs)
		: AnyRadialBasis(ifs) {};

	void RB_Calc(double r);
	void RB_Calc(double r, int i, int j) {RB_Calc(r);}
};

class RadialBasis_vdW : public AnyRadialBasis
{
public:
        static const double ZEROTH_POLY;
        static const double RECURSIVE_COEFF[22][3];
	std::string GetRBTypeString() override
	{
		return "RBvdW";
	}

	RadialBasis_vdW(double _min_dist, double _max_dist, int _size)
		: AnyRadialBasis(_min_dist, _max_dist, _size) {};
	RadialBasis_vdW(std::ifstream& ifs)
		: AnyRadialBasis(ifs) {};

	void RB_Calc(double r);
	void RB_Calc(double r, int i, int j) {RB_Calc(r);}
};

class RadialBasis_vdW_damped : public AnyRadialBasis
{
public:
	static const double COV_RADII[2];
	const double multiplier = 100;
	double a1;
	double a2;

	std::string GetRBTypeString()
	{
		return "RBvdW_damped";
	}

	RadialBasis_vdW_damped(double _min_dist, double _max_dist, int _size,
	double _a1 = -0.33528, double _a2 = 2.86229) : AnyRadialBasis(_min_dist, _max_dist, _size), a1(_a1), a2(_a2)
	{
		if (rb_size > 2)
			ERROR("RadialBasis error: RadialBasis_vdW_damped size shouldn't be greater than 2.");
		rb_vals.resize(rb_size);
		rb_ders.resize(rb_size);
	}
	RadialBasis_vdW_damped(std::ifstream& ifs): RadialBasis_vdW_damped(0.0, 1.0, 1) {
		ReadRadialBasis(ifs);
		if (rb_size > 2)
			ERROR("RadialBasis error: RadialBasis_vdW_damped size shouldn't be greater than 2.");
		};

	void ReadRadialBasis(std::ifstream& ifs) override;
	void WriteRadialBasis(std::ofstream& ofs) override;

	void RB_Calc(double r){ERROR("RadialBasis error: RadialBasis_vdW_damped.RB_Calc(r) called");}
	void RB_Calc(double r, int i, int j) override;
};

class CinfRadialBasis : public AnyRadialBasis
{
private:
        void Init_CinfRadialBasis();
        int size_; // assumed >0
        double mindist_, maxdist_;
        double maxdist_sq_minus_eps; // maxdist after which return zero
        double min_to_max_ratio, maxdist_sq, exp_ratio;
        std::vector<std::array<double, 3>> recursive_coeffs;
        double zeroth_poly;
public:
        std::string GetRBTypeString() override
        {
                return "CinfRadialBasis";
        }

        CinfRadialBasis(double _min_dist, double _max_dist, int _size);
        CinfRadialBasis(std::ifstream& ifs);

        void RB_Calc(double r) override;
		void RB_Calc(double r, int i, int j) {RB_Calc(r);}
};


#endif // MLIP_RADIAL_BASIS_H
