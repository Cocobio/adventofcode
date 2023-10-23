#include <iostream>
#include <unordered_map>

int main() {
    std::unordered_map<char,int> hands = {{'A', 0}, {'B', 1}, {'C', 2},
                                          {'X', 0}, {'Y', 1}, {'Z', 2}};
    std::unordered_map<char,int> target_outcome = {{'X', 0}, {'Y', 3}, {'Z', 6}};

    char oponent, own;

    while (std::cin >> oponent >> own) {
        std::cout << oponent << "\t" << own << "\n";
    }

    return 0;
}
