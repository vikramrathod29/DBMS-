#include <iostream>
using namespace std;

int main() {
    int a[100][100], b[100][100], ans[100][100];
    int i, j, k, rowA, colA, rowB, colB;

    cout << "\nEnter the number of rows and columns for matrix A:\n";
    cin >> rowA >> colA
    
    cout << "\nEnter the elements for matrix A:\n";
    for (i = 0; i < rowA; i++) {
        for (j = 0; j < colA; j++) {
            cout << "a[" << i << "][" << j << "]: ";
            cin >> a[i][j];
        }
    }

    cout << "\nEnter the number of rows and columns for matrix B:\n";
    cin >> rowB >> colB;

    if (colA != rowB) {
        cout << "Matrix multiplication is not possible because the number of columns of A does not equal the number of rows of B.\n";
        return 1;
    }

    cout << "\nEnter the elements for matrix B:\n";
    for (i = 0; i < rowB; i++) {
        for (j = 0; j < colB; j++) {
            cout << "b[" << i << "][" << j << "]: ";
            cin >> b[i][j];
        }
    }

    cout << "\nMatrix A:\n";
    for (i = 0; i < rowA; i++) {
        for (j = 0; j < colA; j++) {
            cout << a[i][j] << " ";
        }
        cout << "\n";
    }

    cout << "\nMatrix B:\n";
    for (i = 0; i < rowB; i++) {
        for (j = 0; j < colB; j++) {
            cout << b[i][j] << " ";
        }
        cout << "\n";
    }

    cout << "\nResult of A * B:\n";
    for (i = 0; i < rowA; i++) {
        for (j = 0; j < colB; j++) {
            ans[i][j] = 0;
            for (k = 0; k < colA; k++) {
                ans[i][j] += a[i][k] * b[k][j];
            }
        }
    }

    for (i = 0; i < rowA; i++)
	 {
        for (j = 0; j < colB; j++) {
            cout << ans[i][j] << " ";
        }
        cout << "\n";
    }

    return 0;
}
