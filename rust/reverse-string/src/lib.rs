use unicode_segmentation::UnicodeSegmentation;

pub fn reverse(input: &str) -> String {
    let mut ans = String::new();
    for gra in input.graphemes(true).rev() {
        ans.push_str(gra);
    }
    return ans;
}
