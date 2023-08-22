#include <cstdlib>
#include <iostream>
#include <queue>

int main() {
    std::string input;
    int total_calories = 0;
    int max_calories = 0;

    std::priority_queue<int> maxs_cal;
    maxs_cal.push(0);
    maxs_cal.push(0);
    maxs_cal.push(0);

    while (getline(std::cin, input)) {
        if (!input.length()) {
            if (max_calories < total_calories) max_calories = total_calories;

            maxs_cal.push(-total_calories);
            maxs_cal.pop();
            total_calories = 0;
            continue;
        }

        total_calories += std::stoi(input);
    }

    std::cout << max_calories << std::endl;
    int maxs_sums = 0;
    while (maxs_cal.size()) {
        maxs_sums -= maxs_cal.top();
        maxs_cal.pop();
    }
    std::cout << maxs_sums << std::endl;

    return 0;
}
