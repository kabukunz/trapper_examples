#pragma once

#include <iostream>
#include <string>

class Runner
{
public:
    Runner(){};
    ~Runner(){};
    void Run();

    std::string msg = {};
};

void Runner::Run()
{
    std::cout << msg << std::endl;
}

int main(int argc, char *argv[])
{
    // context
    std::shared_ptr<Runner> runner = std::make_shared<Runner>();

    // run
    runner->msg = "I am running, or am I not?";
    runner->Run();

    // return result
    return EXIT_SUCCESS;
}
