//#include <stdlib.h>
#include <iostream>
#include <cassert>
#include <vector>
#include <stdint.h>
#include <cfloat>
#include <string>
#include <array>

template<int N>
using VecF = std::array<float, N>;

#pragma pack(push, 1)
template<typename T>
struct timestampedValue
{
  std::uint32_t stamp;
  T data;
};
#pragma pack(pop)

template<typename T>
void wr(char* file,size_t pos,T value)
{
  std::memcpy (file + pos, &value, sizeof (value));
}

void wrHeader(char* file)
{
  wr<std::uint32_t>(file,0x000,'02DM');
  wr<std::uint32_t>(file,0x004,0x00000108);
  wr<std::uint32_t>(file,0x008,0x00000005);
  wr<std::uint32_t>(file,0x00c,0x00000130);
  wr<std::uint32_t>(file,0x01c,0x00000001);
  wr<std::uint32_t>(file,0x020,0x00000140);
  wr<std::uint32_t>(file,0x02c,0x00000001);
  wr<std::uint32_t>(file,0x030,0x00000180);
  wr<std::uint32_t>(file,0x034,0x00000001);
  wr<std::uint32_t>(file,0x038,0x000001e0);
  wr<std::uint32_t>(file,0x044,0x00000001);
  wr<std::uint32_t>(file,0x0a0,0x7F7FFFFF);
  wr<std::uint32_t>(file,0x0a4,0x7F7FFFFF);
  wr<std::uint32_t>(file,0x0a8,0x7F7FFFFF);
  wr<std::uint32_t>(file,0x0ac,0xFF7FFFFF);
  wr<std::uint32_t>(file,0x0b0,0xFF7FFFFF);
  wr<std::uint32_t>(file,0x0b4,0xFF7FFFFF);
  wr<std::uint32_t>(file,0x110,0x00000001);
  wr<std::uint32_t>(file,0x114,0x00000200);
  wr<std::uint32_t>(file,0x118,0x00000001);
  wr<std::uint32_t>(file,0x11c,0x000001f0);
  wr<std::uint32_t>(file,0x130,'_MAC');
}

void wrAnimations(char* file, std::uint32_t animationlength)
{
  wr<std::uint32_t>(file,0x144,animationlength);
  wr<std::uint32_t>(file,0x14c,0x00000020);
  wr<std::uint32_t>(file,0x150,0x00007fff);
  wr<std::uint32_t>(file,0x160,0x7F7FFFFF);
  wr<std::uint32_t>(file,0x164,0x7F7FFFFF);
  wr<std::uint32_t>(file,0x168,0x7F7FFFFF);
  wr<std::uint32_t>(file,0x16c,0xFF7FFFFF);
  wr<std::uint32_t>(file,0x170,0xFF7FFFFF);
  wr<std::uint32_t>(file,0x174,0xFF7FFFFF);
  wr<std::uint32_t>(file,0x17c,0x0000FFFF);
}

void wrBones(char* file)
{
  wr<std::uint32_t>(file,0x180,0xFFFFFFFF);
  wr<std::uint32_t>(file,0x188,0x0000FFFF);
  wr<std::uint32_t>(file,0x190,0xFFFF0000);
  wr<std::uint32_t>(file,0x1a4,0xFFFF0000);
  wr<std::uint32_t>(file,0x1b8,0xFFFF0000);
  
  wr<std::uint32_t>(file,0x1e0,0x0000FFFF);
}

void wrCameras(char* file, const VecF<3>& position, const VecF<3>& target, const std::vector<timestampedValue<VecF<3> > >& rolls, const std::vector<timestampedValue<VecF<9> > >& positions, const std::vector<timestampedValue<VecF<9> > >& targets)
{
  float fov = 0.785398f;
  float farclip = 27.7778f;
  float nearclip = 0.222222f;
  
  wr<std::uint32_t>(file,0x1f0,0x0000FFFF);
  
  wr<std::uint32_t>(file,0x200,0xFFFFFFFF);
  wr<float>(file,0x204,fov);
  wr<float>(file,0x208,farclip);
  wr<float>(file,0x20c,nearclip);
  wr<std::uint32_t>(file,0x210,0xFFFF0001);
  wr<std::uint32_t>(file,0x214,0x00000001);
  wr<std::uint32_t>(file,0x218,0x00000270);
  wr<std::uint32_t>(file,0x21c,0x00000001);
  wr<std::uint32_t>(file,0x220,0x00000278);
  wr<VecF<3>>(file,0x224,position);
  wr<std::uint32_t>(file,0x230,0xFFFF0001);
  wr<std::uint32_t>(file,0x234,0x00000001);
  wr<std::uint32_t>(file,0x238,0x00000280);
  wr<std::uint32_t>(file,0x23c,0x00000001);
  wr<std::uint32_t>(file,0x240,0x00000288);
  wr<VecF<3>>(file,0x244,target);
  wr<std::uint32_t>(file,0x250,0xFFFF0002);
  wr<std::uint32_t>(file,0x254,0x00000001);
  wr<std::uint32_t>(file,0x258,0x00000290);
  wr<std::uint32_t>(file,0x25c,0x00000001);
  wr<std::uint32_t>(file,0x260,0x00000298);
  
  const auto pos_timestamps = 0x2a0;
  const auto pos_data = pos_timestamps + positions.size() * sizeof(uint32_t);
  
  const auto tar_timestamps = pos_data + positions.size() * sizeof(VecF<9>);
  const auto tar_data = tar_timestamps + targets.size() * sizeof(uint32_t);
  
  const auto roll_timestamps = tar_data + targets.size() * sizeof(VecF<9>);
  const auto roll_data = roll_timestamps + rolls.size() * sizeof(uint32_t);
  
  wr<std::uint32_t>(file,0x270,positions.size());
  wr<std::uint32_t>(file,0x274,pos_timestamps);
  wr<std::uint32_t>(file,0x278,positions.size());
  wr<std::uint32_t>(file,0x27c,pos_data);
  wr<std::uint32_t>(file,0x280,targets.size());
  wr<std::uint32_t>(file,0x284,tar_timestamps);
  wr<std::uint32_t>(file,0x288,targets.size());
  wr<std::uint32_t>(file,0x28c,tar_data);
  wr<std::uint32_t>(file,0x290,rolls.size());
  wr<std::uint32_t>(file,0x294,roll_timestamps);
  wr<std::uint32_t>(file,0x298,rolls.size());
  wr<std::uint32_t>(file,0x29c,roll_data);
  
  for(std::size_t i=0;i<positions.size();++i)
  {
    wr<std::uint32_t>(file,pos_timestamps+sizeof(uint32_t)*i,positions[i].stamp);
    wr<VecF<9>>(file,pos_data+sizeof(VecF<9>)*i,positions[i].data);
  }
  
  for(std::size_t i=0;i<targets.size();++i)
  {
    wr<std::uint32_t>(file,tar_timestamps+sizeof(uint32_t)*i,targets[i].stamp);
    wr<VecF<9>>(file,tar_data+sizeof(VecF<9>)*i,targets[i].data);
  }
  
  for(std::size_t i=0;i<rolls.size();++i)
  {
    wr<std::uint32_t>(file,roll_timestamps+sizeof(uint32_t)*i,rolls[i].stamp);
    wr<VecF<3>>(file,roll_data+sizeof(VecF<3>)*i,rolls[i].data);
  }
}

int main(int,char**)
{
  // Change this - it is how long the cinematic lasts for (30000 = 30 seconds)
  std::uint32_t animationlength = 45000;
  
  std::vector<timestampedValue<VecF<3> > > rolls;
  std::vector<timestampedValue<VecF<9> > > positions;
  std::vector<timestampedValue<VecF<9> > > targets;

  positions.push_back ({    0, {208.00f,   3.00f,  9.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  positions.push_back ({19000, { 70.00f,   3.00f,  8.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  positions.push_back ({25000, { 60.00f,  40.00f,  8.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  positions.push_back ({30000, { 68.00f,  66.00f, 10.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  positions.push_back ({34000, { 82.00f,  66.00f, 14.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  positions.push_back ({34100, { 90.00f, 120.00f, 16.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  positions.push_back ({40000, {128.00f, 124.00f, 16.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});

  targets.push_back ({    0, {  0.00f,   0.00f,  3.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  targets.push_back ({18000, {  0.00f,   0.00f,  5.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  targets.push_back ({20000, { 60.00f,  40.00f,  8.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  targets.push_back ({30000, {100.00f, 100.00f, 15.00f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});
  targets.push_back ({35000, {135.00f, 125.00f, 13.50f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f}});

  rolls.push_back ({0, {0.0f, 0.0f, 0.0f}});

  // base position + target
  VecF<3> position {0.0f, 0.0f, 1.0f};
  VecF<3> target {0.0f, 0.0f, 2.0f};
    
  uint32_t size = 0x2a0 + (positions.size()+targets.size()) * (sizeof(uint32_t)+sizeof(VecF<9>)) + rolls.size() * (sizeof(uint32_t)+sizeof(VecF<3>));
  
  std::vector<char> file (size);
  
  wrHeader(file.data());
  wrAnimations(file.data(), animationlength);
  wrBones(file.data());
  wrCameras(file.data(), position, target, rolls, positions, targets);
  
  FILE* f = fopen("C:\\WoW 3.3.5\\Cameras\\FallOfDalaran.m2","w+");
  fwrite(file.data(),file.size(),1,f);
  fclose(f);
  
  return 0;
}
