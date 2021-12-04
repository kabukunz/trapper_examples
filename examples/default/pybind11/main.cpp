#pragma once

#include <iostream>
#include <string>

class MyClass
{
private:
    std::string runmsg = "I am running, am I?";
public:
    MyClass(){};
    ~MyClass(){};
    bool Run();
};

MyClass::Run()
{
    std::cout << runmsg << std::endl;
}

int main(int argc, char *argv[])
{
    // context
    std::shared_ptr<MyClass> myClass = std::make_shared<MyClass>();

    // run
    bool result = myClass->run();

    // return result
    return (result) ? EXIT_SUCCESS : EXIT_FAILURE;    
}

