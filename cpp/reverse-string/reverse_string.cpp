#include <iostream>
#include <string>
#include <ranges>  // C++20
#include "reverse_string.h"

using namespace std;

namespace reverse_string {

    string reverse_string(string str) {
        if (str == "") return "";
        string res;
        // for (auto p_str = str.crbegin(); p_str != str.crend(); ++p_str) {
        for (auto& ch : str | std::views::reverse) {
            // res.push_back(*p_str);
            res.push_back(ch);
        }
        return res;
    }

    int main() {
        // test1 
        string english{"Brown Fox"};
        cout << "orig: " << english << "; reversed: " << reverse_string(english) << "\n";

        // test2
        string hanji{"潘科元"};
        cout << "orig: " << hanji << "; reversed: " << reverse_string(hanji) << "\n";
        
        // test3
        string taigi{"Phuann Kho-guân"};
        cout << "orig: " << taigi << "; reversed: " << reverse_string(taigi) << "\n";
       
        return 0;
    } 
}  // namespace reverse_string

int main() {
    reverse_string::main();

    return 0;
}
