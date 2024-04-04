#include "reverse_string.h"

namespace reverse_string {
    using namespace std;

    string reverse_string(string str) {
        if (str == "") return "";
        string res;
        for (auto p_str = str.crbegin(); p_str != str.crend(); ++p_str) {
            res.push_back(*p_str);
        }
        return res;
    }
}  // namespace reverse_string
