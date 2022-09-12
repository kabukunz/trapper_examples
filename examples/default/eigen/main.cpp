
#include <Eigen/Core>

#include <iostream>

int main(int argc, char **argv)
{
    using namespace std;
    using namespace Eigen;

    MatrixXd V(3,3);
    V.setRandom();

    cout << V << endl;

    return EXIT_SUCCESS;
}
