//
//  ViewController.m
//  TraceDemo
//
//  Created by hank on 2020/11/21.
//  Copyright © 2020 hank. All rights reserved.
//

#import "ViewController.h"
#include <stdint.h>
#include <stdio.h>
#include <sanitizer/coverage_interface.h>


#import <dlfcn.h>



@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.cyanColor;
}


void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++){
      
      
      
/*
 
 3

 static gives the variable a lifetime for the entire program execution. So the variable in this example retains its value across function calls. A non-static variable on the other hand would have a lifetime of just this function and be re-intialised each time (if there were an initialiser which it doesn't in this example). 
 
 */
      
      
      *x = (uint32_t)++N;           //  这一行确保，不会重复输出
      
      
      printf("INIT: %p \n", x);
      Dl_info info = {0};
      dladdr(x, &info);
//        printf("%s \n",info.dli_sname);
      NSString * name = @(info.dli_sname);
      NSLog(@"%@", name);
  }
  
    
}


void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
}


@end
