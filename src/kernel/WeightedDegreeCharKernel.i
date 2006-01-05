%module WeightedDegreeCharKernel%{
 #include "kernel/WeightedDegreeCharKernel.h" 
%}

%include "kernel/CharKernel.i"

%include "carrays.i"
%array_class(int, intArray);
%array_class(double, doubleArray);
%array_class(char, charArray);

typedef int INT;
typedef double REAL;
typedef char CHAR;
typedef int LONG;

%feature("notabstract") CWeightedDegreeCharKernel;

class CWeightedDegreeCharKernel: public CCharKernel
{
 public:
  CWeightedDegreeCharKernel(LONG size, REAL* weights, INT degree, INT max_mismatch, bool use_normalization=true, bool block_computation=false, INT mkl_stepsize=1) ;
  ~CWeightedDegreeCharKernel() ;
  
  virtual bool init(CFeatures* l, CFeatures* r, bool do_init);
  virtual void cleanup();

  /// load and save kernel init_data
  bool load_init(FILE* src);
  bool save_init(FILE* dest);

  // return what type of kernel we are Linear,Polynomial, Gaussian,...
  virtual EKernelType get_kernel_type() { return K_WEIGHTEDDEGREE; }

  // return the name of a kernel
  virtual const CHAR* get_name() { return "WeightedDegree" ; } ;

  virtual bool init_optimization(INT count, INT * IDX, REAL * weights) ;
  virtual bool delete_optimization() ;
  virtual REAL compute_optimized(INT idx);
  
  // subkernel functionality
  inline virtual void clear_normal();
  protected:

  void add_example_to_tree(INT idx, REAL weight);
  void add_example_to_tree_mismatch(INT idx, REAL weight);
  void add_example_to_tree_mismatch_recursion(struct Trie *tree,  REAL alpha,
											  INT *vec, INT len_rem, 
											  INT depth_rec, INT mismatch_rec) ;
};
