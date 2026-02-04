#include <iostream>

/// <summary>
/// Converts a binary number to decimal
/// </summary>
/// <param name="binary"> The binary number </param>
/// <returns> The decimal equivalent </returns>
unsigned long binaryToDecimal(std::string binary) {
    unsigned long decimal = 0u;
    // loops over every bit
    for (int i = 0; i < binary.length(); ++i) {
        decimal *= 2u; // doubles the decimal for each bit since binary is in base 2
        decimal += binary.at(i) - '0'; // adds one if the bit is a one
    }
    return decimal;
}

/// <summary>
/// Converts a hexadecimal number to decimal
/// </summary>
/// <param name="hex"> The hexadecimal number </param>
/// <returns> The decimal equivalent </returns>
unsigned long hexadecimalToDecimal(std::string hex) {
    unsigned long decimal = 0u;
    // loops over every character
    for (int i = 2; i < hex.length(); ++i) {
        decimal *= 16u; // multiplies the decimal by 16 for each character since hexadecimals are in base 16
        // checks if the character is a digit or a letter
        // appropriately adds the proper value to the decimal
        if (hex.at(i) <= '9')
            decimal += hex.at(i) - '0';
        else if (hex.at(i) >= 'A' && hex.at(i) <= 'F')
            decimal += hex.at(i) - 'A' + 10;
        else if (hex.at(i) >= 'a' && hex.at(i) <= 'f')
            decimal += hex.at(i) - 'a' + 10;
    }
    return decimal;
}

bool test(unsigned long answer, std::string input, unsigned long expectedAnswer);

int main() {

    // Problem 1: Binary
    // __________________________________________________________________________________________________
    bool testsPassed = true;

    // Small
    std::cout << "Small: " << std::endl;
    testsPassed = test(binaryToDecimal("0000000000000001"), "0000000000000001", 1u) && testsPassed;
    testsPassed = test(binaryToDecimal("0000000000000100"), "0000000000000100", 4u) && testsPassed;
    testsPassed = test(binaryToDecimal("0000000000000000"), "0000000000000000", 0u) && testsPassed;
    std::cout << std::endl;

    // Middle
    std::cout << "Middle:" << std::endl;
    testsPassed = test(binaryToDecimal("1000000000000000"), "1000000000000000", 32768u) && testsPassed;
    testsPassed = test(binaryToDecimal("0100001000000001"), "0100001000000001", 16897u) && testsPassed;
    testsPassed = test(binaryToDecimal("0101010101010101"), "0101010101010101", 21845u) && testsPassed;
    std::cout << std::endl;

    // Full 16-bit
    std::cout << "Full 16-bit:" << std::endl;
    testsPassed = test(binaryToDecimal("1111111111111111"), "1111111111111111", 65535u) && testsPassed;
    testsPassed = test(binaryToDecimal("1111111100000000"), "1111111100000000", 65280u) && testsPassed;
    std::cout << std::endl;

    if (testsPassed)
        std::cout << "16-bit binary tests passed!\n" << std::endl;


    // Problem 2: Hexadecimal
    // __________________________________________________________________________________________________
    testsPassed = true;

    // Small
    std::cout << "Small: " << std::endl;
    testsPassed = test(hexadecimalToDecimal("0x00000001"), "0x00000001", 1u) && testsPassed;
    testsPassed = test(hexadecimalToDecimal("0x00000000"), "0x00000000", 0u) && testsPassed;
    testsPassed = test(hexadecimalToDecimal("0x0000000A"), "0x0000000A", 10u) && testsPassed;
    std::cout << std::endl;

    // Middle
    std::cout << "Middle: " << std::endl;
    testsPassed = test(hexadecimalToDecimal("0x80000000"), "0x80000000", 2147483648u) && testsPassed;
    testsPassed = test(hexadecimalToDecimal("0x55555555"), "0x55555555", 1431655765u) && testsPassed;
    testsPassed = test(hexadecimalToDecimal("0x89ABCDEF"), "0x89ABCDEF", 2309737967u) && testsPassed;
    std::cout << std::endl;

    // Full 32-bit
    std::cout << "Full 32-bit: " << std::endl;
    testsPassed = test(hexadecimalToDecimal("0xFFFFFFFF"), "0xFFFFFFFF", 4294967295u) && testsPassed;
    testsPassed = test(hexadecimalToDecimal("0xFFFFFFFE"), "0xFFFFFFFE", 4294967294u) && testsPassed;
    std::cout << std::endl;

    if (testsPassed)
        std::cout << "32-bit hex tests passed!\n" << std::endl;
}

bool test(unsigned long answer, std::string input, unsigned long expectedAnswer) {
    if (answer != expectedAnswer) {
        std::cout << input << "\t" << "TEST FAILED" << std::endl;
        return false;
    }
    std::cout << input << " = " << answer;
    std::cout << " | Expected: [" << input << " = " << expectedAnswer << "]" << std::endl;
    return true;
}
