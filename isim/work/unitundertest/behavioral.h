////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_unitundertest_behavioral_H
#define H_Work_unitundertest_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_unitundertest_behavioral: public HSim__s6 {
public:

    HSim__s1 SE[2];

    HSim__s1 SA[8];
  char *t0;
HSimConstraints *c1;
HSimConstraints *c2;
HSimConstraints *c3;
  char *t4;
  char *t5;
    Work_unitundertest_behavioral(const char * name);
    ~Work_unitundertest_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_unitundertest_behavioral(const char *name);

#endif
