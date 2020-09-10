#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <assert.h>

#define ALL_SOLUTIONS -1 
#define NO_ROOTS 0
#define ONE_ROOT 1
#define TWO_ROOTS 2

int Solve_equation(double a, double b, double c, double* x1, double* x2);
int ChekingZero(double value);
void Tests();

//! Print roots of square equation
//! 
//! @param [in]	Num_roots	Number of roots of a square equation					
//! @param[out]	x1			The first root
//! @param[out] x2			The second root
//! 
//! @note In case the equation has one root, the output is x1.
//! @note In case the equation has no roots, the output is "No roots".
//! @note In case of infinite number of roots, the output is "Solutions are all numbers".
//! 
//! @attention If the coefficients are entered incorrectly, the output is "Error"
							
int main()
{
	Tests();

	printf("Enter a,b,c: ");

	double a = 0, b = 0, c = 0;

	if (scanf_s("%lg  %lg  %lg", &a, &b, &c) != 3)
	{
		printf("Error\n");
		return 0;
	}

	double x1 = 0, x2 = 0;

	int Num_roots = Solve_equation(a, b, c, &x1, &x2);

	assert(isfinite(x1));
	assert(isfinite(x2));
	 
	switch (Num_roots)
	{
	case NO_ROOTS:
		printf("No roots\n");
		break;
	case ONE_ROOT:
		printf("x = %lg\n", x1);
		break;
	case TWO_ROOTS:
		printf("x1 = %lg, x2 = %lg \n", x1, x2);
		break;
	case ALL_SOLUTIONS:	
		printf("Solutions are all numbers\n");
		break;
	default: 
		printf("main() : ERROR: Num_roots = %d\n ", Num_roots);
		break;
	}
	return 0;
}

//! Solves a square equation
//! 
//! @param [in]		a	a-coefficient  
//! @param [in]		b	b-coefficient
//! @param [in]		c	c-coefficient
//! @param [out]	x1	x1-Pointer to the 1st root
//! @param [out]	x2	x2-Pointer to the 2nd root
//! 
//! @return Number of roots
//! 
//! @note	In case of infinite number of roots
//!			returns ALL_SOLUTIONS 

int Solve_equation(double a, double b, double c, double* x1, double* x2)
{
	assert(isfinite(a));
	assert(isfinite(b));
	assert(isfinite(c));

	assert(x1 != NULL);
	assert(x2 != NULL);
	assert(x1 != x2);

	if (ChekingZero(a))
	{
		if (ChekingZero(b))
		{
			if (ChekingZero(c))
			{
				return ALL_SOLUTIONS;
			}
			else
			{
				return NO_ROOTS;
			}
		}
		else
		{
			*x1 = (-c) / b;
			return ONE_ROOT;
		}
	}
	else
	{
		double d = b * b - 4 * a * c;
		if (ChekingZero(d))
		{
			*x1 = *x2 = -b / (2 * a);

			return ONE_ROOT;
		}
		else
		{
			if (d < 0)
			{
				return NO_ROOTS;
			}
			else
			{
				double square_root = sqrt(d);
				*x1 = (-b + square_root) / (2 * a);
				*x2 = (-b - square_root) / (2 * a);
				return TWO_ROOTS;
			}
		}
	}
}

//! This function allows to compare values against zero
//!
//! @param[in] value   The value of the variable to be compared
//! 
//! @return 1 - if the condition is met, 0 - if the condition is not met

int ChekingZero (double value)
	{
	return(fabs(value) <= 1e-5);
	}

//!This function allows to check correctness of the program

void Tests()
{
	FILE* in = fopen("in.txt", "r");;
	FILE* out =  fopen("out.txt", "w");;

	double a = 0, b = 0, c = 0, x1 = 0, x2 = 0;

	while (fscanf(in, "%lg %lg %lg", &a, &b, &c) > 0)
	{
		int Num_roots = Solve_equation(a, b, c, &x1, &x2);

		assert(isfinite(x1));
		assert(isfinite(x2));

		switch (Num_roots)
		{
		case 0:
			fprintf(out, "No roots\n");
			break;
		case 1:
			fprintf(out, "x = %lg\n", x1);
			break;
		case 2:
			fprintf(out, "x1 = %lg  ", x1);
			fprintf(out, "x2 = %lg\n", x2);
			break;
		case ALL_SOLUTIONS:
			fprintf(out, "Solutions are all numbers\n");
			break;
		default:
			fprintf(out, "main() : ERROR: Num_roots = %d\n ", Num_roots);
			break;
		}
	}
	fclose(in);
	fclose(out);
}
