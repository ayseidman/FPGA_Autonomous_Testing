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

#ifndef H_Work_compressioncounter_behavioral_H
#define H_Work_compressioncounter_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_compressioncounter_behavioral: public HSim__s6 {
public:

    HSim__s4 PE[1];
    HSim__s1 SE[5];

    HSim__s1 SA[2];
  char t3;
    Work_compressioncounter_behavioral(const char * name);
    ~Work_compressioncounter_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
    int ConvFunc1(HSim__s2 * drv, const char * src, int noOfBytes, const HSimConstraints * srcConstraints);
};



HSim__s6 *createWork_compressioncounter_behavioral(const char *name);

#endif
