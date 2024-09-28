#!/usr/bin/env python3
import glob, os

def is_double(number):
    is_number = True
    try:
        num = float(number)
        # check for "nan" floats
        is_number = num == num   # or use `math.isnan(num)`
    except ValueError:
        is_number = False
    return is_number

def write(content):
    f.write(content)
def writeln(content):
    write(content)
    write("\n")
    
precision = 20

def isRepresentableAsDouble(string):
    return False
    test = string
    if "." in string:
        while test[-1] == "0":
            test.removeLast()
        
    
    if len(test) > 16:
        return False
    
    if "." in string:
        if test == "3":
            test = test[:-1]
            test = test + "9"
        elif test[-1] == ".":
            test = test + "3"
        else:
            test = test[:-1]
            test = test + "3"
    else:
        if test[-1] == "3":
            test = test[:-1]
            test = test + "9"
        else:
            test = test[:-1]
            test = test + "3"

    selfDouble = float(string)
    testDouble = float(test)
    return testDouble != selfDouble


def assertEqual(components):
    if not (components[-2] == "=" or components[-2] == "~=" or components[-2] == "!="):
        print("second last not \"=\", \"~=\", \"!=\"")
        print(components)
        return

    write("    leftNumber = ")
    for component in components[:-2]:
        if is_double(component):
            if len(component) <= 16:
                write("Number(" + component + ", precision: precision)")
            else:
                write("Number(\"" + component + "\", precision: precision)")
        else:
            operator = component
            if operator == "+" or operator == "-" or operator == "*" or operator == "/":
                write(" "+component+" ")
            else:
                writeln("")
                write("    leftNumber.inplace_"+operator+"()")
    writeln("")
    if components[-1] == "infinity":
        writeln("    #expect(leftNumber.isInfinity)")
    else:
        if components[-2] == "=":
            writeln("    #expect(leftNumber.representation().allInOneLine == \"" + components[-1] + "\")")
        elif components[-2] == "!=":
            writeln("    #expect(leftNumber.representation().allInOneLine != \"" + components[-1] + "\")")
        elif components[-2] == "~=":
            writeln("    #expect(leftNumber.toDouble().similarTo(" + components[-1] + "))")

# Get full file name with directores using for loop
for file in glob.glob("*.txt"):
    basename = os.path.basename(file).replace(".txt", "")

    print(basename+"Test.swift")
    f = open(basename+"Test.swift", 'w')
    writeln("// Note: This file is automatically generated.")
    writeln("//       It will be overwritten sooner or later.")
    writeln("")
    writeln("import Testing")
    writeln("import SwiftGmp")
    writeln("")
    writeln("@Test func "+basename+"Test() {")
    writeln("    let calculator = Calculator(precision: 20)")
    writeln("")
    with open(file) as file:
        for line in file:
            line = line.strip()
            if len(line) > 0:
                contentAndComment = line.split("//")
                content = contentAndComment[0].strip()
                comment = " ".join(contentAndComment[1:]).strip()

                if len(content) == 0:
                    if len(comment) > 0:
                        writeln("// "+comment)
                else:
                    if "=" in content:
#                        components = content.strip().split("=")
#                        if len(components) == 2:
#                            if components[0].strip() == "precision":
#                                writeln("    calculator.setPrecision(newPrecision: "+components[1].strip()+")")
#                            else:
#                                writeln("    #expect(calculator.calc(\""+components[0].strip()+"\") == \""+components[1].strip()+"\")")
                        components = content.strip().split("~=")
                        if len(components) == 2:
                            if components[0].strip() == "precision":
                                writeln("    calculator.setPrecision(newPrecision: "+components[1].strip()+")")
                            else:
                                writeln("    #expect(calculator.calc(\""+components[0].strip()+"\").hasPrefix(\""+components[1].strip()+"\"))")
                    if "~=" in content:
                        components = content.strip().split("~=")
                        if len(components) == 2:
                            if components[0].strip() == "precision":
                                writeln("    calculator.setPrecision(newPrecision: "+components[1].strip()+")")
                            else:
                                writeln("    #expect(calculator.calc(\""+components[0].strip()+"\").hasPrefix(\""+components[1].strip()+"\"))")
    writeln("}")
    f.close()
