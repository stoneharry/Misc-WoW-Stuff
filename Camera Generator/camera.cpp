//#include <stdlib.h>
#include <iostream>
#include <cassert>
#include <vector>
#include <stdint.h>
#include <cfloat>
#include <string>

template<int N>
struct VecF
{
  float d[N];
  VecF(float x[N])
  {
    for(int i=0;i<N;i++) d[i]=x[i];
  }
  VecF()
  {
    for(int i=0;i<N;i++) d[i]=0.0f;
  }
};

template<typename T>
struct timestampedValue
{
  uint32_t stamp;
  T data;
};

template<typename T>
void wr(char* file,size_t pos,T value)
{
  *((T*)(file+pos)) = value;
}

void wrHeader(char* file)
{
  wr(file,0x000,'02DM');
  wr(file,0x004,0x00000108);
  wr(file,0x008,0x00000005);
  wr(file,0x00c,0x00000130);
  wr(file,0x01c,0x00000001);
  wr(file,0x020,0x00000140);
  wr(file,0x02c,0x00000001);
  wr(file,0x030,0x00000180);
  wr(file,0x034,0x00000001);
  wr(file,0x038,0x000001e0);
  wr(file,0x044,0x00000001);
  wr(file,0x0a0,0x7F7FFFFF);
  wr(file,0x0a4,0x7F7FFFFF);
  wr(file,0x0a8,0x7F7FFFFF);
  wr(file,0x0ac,0xFF7FFFFF);
  wr(file,0x0b0,0xFF7FFFFF);
  wr(file,0x0b4,0xFF7FFFFF);
  wr(file,0x110,0x00000001);
  wr(file,0x114,0x00000200);
  wr(file,0x118,0x00000001);
  wr(file,0x11c,0x000001f0);
  wr(file,0x130,'_MAC');
}

void wrAnimations(char* file, int animationlength)
{
  wr(file,0x144,animationlength);
  wr(file,0x14c,0x00000020);
  wr(file,0x150,0x00007fff);
  wr(file,0x160,0x7F7FFFFF);
  wr(file,0x164,0x7F7FFFFF);
  wr(file,0x168,0x7F7FFFFF);
  wr(file,0x16c,0xFF7FFFFF);
  wr(file,0x170,0xFF7FFFFF);
  wr(file,0x174,0xFF7FFFFF);
  wr(file,0x17c,0x0000FFFF);
}

void wrBones(char* file)
{
  wr(file,0x180,0xFFFFFFFF);
  wr(file,0x188,0x0000FFFF);
  wr(file,0x190,0xFFFF0000);
  wr(file,0x1a4,0xFFFF0000);
  wr(file,0x1b8,0xFFFF0000);
  
  wr(file,0x1e0,0x0000FFFF);
}

void wrCameras(char* file, const VecF<3>& position, const VecF<3>& target, const std::vector<timestampedValue<VecF<3> > >& rolls, const std::vector<timestampedValue<VecF<9> > >& positions, const std::vector<timestampedValue<VecF<9> > >& targets)
{
  float fov = 0.785398f;
  float farclip = 27.7778f;
  float nearclip = 0.222222f;
  
  wr(file,0x1f0,0x0000FFFF);
  
  wr(file,0x200,0xFFFFFFFF);
  wr(file,0x204,fov);
  wr(file,0x208,farclip);
  wr(file,0x20c,nearclip);
  wr(file,0x210,0xFFFF0001);
  wr(file,0x214,0x00000001);
  wr(file,0x218,0x00000270);
  wr(file,0x21c,0x00000001);
  wr(file,0x220,0x00000278);
  wr(file,0x224,position);
  wr(file,0x230,0xFFFF0001);
  wr(file,0x234,0x00000001);
  wr(file,0x238,0x00000280);
  wr(file,0x23c,0x00000001);
  wr(file,0x240,0x00000288);
  wr(file,0x244,target);
  wr(file,0x250,0xFFFF0002);
  wr(file,0x254,0x00000001);
  wr(file,0x258,0x00000290);
  wr(file,0x25c,0x00000001);
  wr(file,0x260,0x00000298);
  
  uint32_t pos_timestamps = 0x2a0;
  uint32_t pos_data = pos_timestamps + positions.size() * sizeof(uint32_t);
  
  uint32_t tar_timestamps = pos_data + positions.size() * sizeof(float)*9;
  uint32_t tar_data = tar_timestamps + targets.size() * sizeof(uint32_t);
  
  uint32_t roll_timestamps = tar_data + targets.size() * sizeof(float)*9;
  uint32_t roll_data = roll_timestamps + rolls.size() * sizeof(uint32_t);
  
  wr(file,0x270,positions.size());
  wr(file,0x274,pos_timestamps);
  wr(file,0x278,positions.size());
  wr(file,0x27c,pos_data);
  wr(file,0x280,targets.size());
  wr(file,0x284,tar_timestamps);
  wr(file,0x288,targets.size());
  wr(file,0x28c,tar_data);
  wr(file,0x290,rolls.size());
  wr(file,0x294,roll_timestamps);
  wr(file,0x298,rolls.size());
  wr(file,0x29c,roll_data);
  
  for(int i=0;i<positions.size();++i)
  {
    wr(file,pos_timestamps+sizeof(uint32_t)*i,positions[i].stamp);
    wr(file,pos_data+sizeof(float)*9*i,positions[i].data);
  }
  
  for(int i=0;i<targets.size();++i)
  {
    wr(file,tar_timestamps+sizeof(uint32_t)*i,targets[i].stamp);
    wr(file,tar_data+sizeof(float)*9*i,targets[i].data);
  }
  
  for(int i=0;i<rolls.size();++i)
  {
    wr(file,roll_timestamps+sizeof(uint32_t)*i,rolls[i].stamp);
    wr(file,roll_data+sizeof(float)*3*i,rolls[i].data);
  }
}

int main(int argc,char** argv)
{
	// Change this - it is how long the cinematic lasts for (30000 = 30 seconds)
	int animationlength = 45000;
  
	std::vector<timestampedValue<VecF<3> > > rolls;
	std::vector<timestampedValue<VecF<9> > > positions;
	std::vector<timestampedValue<VecF<9> > > targets;

	// Hold temp data
	timestampedValue<VecF<9> > fake9;

	// Positions push data into real vector
	fake9.stamp = 0000; fake9.data.d[0] = 208.00f; fake9.data.d[1] = 3.00f; fake9.data.d[2] = 9.00f;
	positions.push_back(fake9);
	fake9.stamp = 19000; fake9.data.d[0] = 70.00f; fake9.data.d[1] = 3.00f; fake9.data.d[2] = 8.00f;
	positions.push_back(fake9);
	fake9.stamp = 25000; fake9.data.d[0] = 60.00f; fake9.data.d[1] = 40.00f; fake9.data.d[2] = 8.00f;
	positions.push_back(fake9);
	fake9.stamp = 30000; fake9.data.d[0] = 68.00f; fake9.data.d[1] = 66.00f; fake9.data.d[2] = 10.00f;
	positions.push_back(fake9);
	fake9.stamp = 34000; fake9.data.d[0] = 82.00f; fake9.data.d[1] = 66.00f; fake9.data.d[2] = 14.00f;
	positions.push_back(fake9);
	//fake9.stamp = 37000; fake9.data.d[0] = 90.00f; fake9.data.d[1] = 67.00f; fake9.data.d[2] = 16.00f;
	//positions.push_back(fake9);
	//fake9.stamp = 44000; fake9.data.d[0] = 70.00f; fake9.data.d[1] = 95.00f; fake9.data.d[2] = 16.00f;
	//positions.push_back(fake9);
	//fake9.stamp = 55000; fake9.data.d[0] = 60.00f; fake9.data.d[1] = 60.00f; fake9.data.d[2] = 16.50f;
	//positions.push_back(fake9);
	fake9.stamp = 34100; fake9.data.d[0] = 90.00f; fake9.data.d[1] = 120.00f; fake9.data.d[2] = 16.00f;
	positions.push_back(fake9);
	fake9.stamp = 40000; fake9.data.d[0] = 128.00f; fake9.data.d[1] = 124.00f; fake9.data.d[2] = 16.00f;
	positions.push_back(fake9);

	// Targets push data into real vector
	fake9.stamp = 0000; fake9.data.d[0] = 0.00f; fake9.data.d[1] = 0.00f; fake9.data.d[2] = 3.00f;
	targets.push_back(fake9);
	fake9.stamp = 18000; fake9.data.d[0] = 0.00f; fake9.data.d[1] = 0.00f; fake9.data.d[2] = 5.00f;
	targets.push_back(fake9);
	fake9.stamp = 20000; fake9.data.d[0] = 60.00f; fake9.data.d[1] = 40.00f; fake9.data.d[2] = 8.00f;
	targets.push_back(fake9);
	fake9.stamp = 30000; fake9.data.d[0] = 100.00f; fake9.data.d[1] = 100.00f; fake9.data.d[2] = 15.00f;
	targets.push_back(fake9);
	fake9.stamp = 35000; fake9.data.d[0] = 135.00f; fake9.data.d[1] = 125.00f; fake9.data.d[2] = 13.50f;
	targets.push_back(fake9);
	
	VecF<3> position; position.d[0] = 0.0f; position.d[1] = 0.0f; position.d[2] = 1.0f;
	VecF<3> target; target.d[0] = 0.0f; target.d[1] = 0.0f; target.d[2] = 2.0f;
    
	uint32_t size = 0x2a0 + (positions.size()+targets.size()) * (sizeof(uint32_t)+sizeof(float)*9) + rolls.size() * (sizeof(uint32_t)+sizeof(float)*3);
  
	char* file = new char[size];
	memset(file,0,size);
  
	wrHeader(file);
	wrAnimations(file, animationlength);
	wrBones(file);
	wrCameras(file, position, target, rolls, positions, targets);
  
	FILE* f = fopen("C:\\WoW 3.3.5\\Cameras\\FallOfDalaran.m2","w+");
	fwrite(file,size,1,f);
	fclose(f);
  
	delete[] file;
  
	return 0;
}

const char* getfield(char* line, int num)
{
    const char* tok;
    for (tok = strtok(line, ",");
            tok && *tok;
            tok = strtok(NULL, ",\n"))
    {
        if (!--num)
            return tok;
    }
    return NULL;
}

int to_int(char const *s, size_t count)
{
     size_t i = 0 ;
     if ( s[0] == '+' || s[0] == '-' ) 
          ++i;
     int result = 0;
     while(s[i] != '.')
     {
          if ( s[i] >= '0' && s[i] <= '9' )
          {
              result = result * 10  - (s[i] - '0');  //assume negative number
          }
          else
              throw std::invalid_argument("invalid input string");
          i++;
     }
     return s[0] == '-' ? result : -result; //-result is positive!
}