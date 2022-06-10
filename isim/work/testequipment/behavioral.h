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

#ifndef H_Work_testequipment_behavioral_H
#define H_Work_testequipment_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_testequipment_behavioral: public HSim__s6 {
public:

    HSim__s4 PE[6];
    HSim__s1 SE[8];

HSimConstraints *c0;
  char *t1;
HSim__s4 C2r;
HSim__s4 C2C;
    HSim__s1 SA[5];
    Work_testequipment_behavioral(const char * name);
    ~Work_testequipment_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_testequipment_behavioral(const char *name);

#endif
