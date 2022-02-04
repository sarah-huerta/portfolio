

import functions as f

def main():
    f.get_requirements()

    f.estimate_painting_cost()
    choice = str(input('Estimate another paint job? (y/n): '))

    while choice == 'y':
        f.estimate_painting_cost()
        choice = str(input('Estimate another paint job? (y/n): '))
    else:

        print("\nThank you for using our Paint Estimator!")
if __name__ == "__main__":
    main()
