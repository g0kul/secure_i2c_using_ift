#!/usr/bin/perl

use Term::ANSIColor;

my $z3home ="z3";
my $option = "smt2";
my $iverilog = "iverilog";

my $config = "-F i2cworld.fun -l i2cworld.lattice";

my $fail_counter = 0;
my $counter = 0;

sub print_ok {
  print colored("verified\n", 'green');
}

sub print_fail {
  print colored("fail\n", 'red');
}

# type check all files with .v extension in current directory
# first generate the z3 files
#my @files = ("i2c_world_top.v", "i2c_master_top.v", "i2c_master_defines.v", "i2c_master_byte_ctrl.v", "i2c_master_bit_ctrl.v", "timescale.v", "i2cSlave.v", "serialInterface.v", "registerInterface.v");
my @files = ("i2c_world_top.v", "i2c_master_top.v", "i2c_master_defines.v", "i2c_master_byte_ctrl.v", "i2c_master_bit_ctrl.v", "timescale.v", "i2cSlave.v", "serialInterface.v", "registerInterface.v", "i2c_sys_top.v");
foreach my $file (@files) {
  if (-f $file and $file =~ /\.v$/) {
    # run iverilog to generate constraints
    print "Compiling file $file\n";
    `$iverilog $config -z $file`;
    #system ($iverilog, $config, "-z", $file);
  }
}

my @files = <*>;
foreach my $file (@files) {
  if (-f $file and $file =~ /\.z3$/) {
    my ($prefix) = $file =~ m/(.*)\.z3$/;
    print "Verifying module $prefix ";

    # read the output of Z3
    my $str = `z3 -$option $file`;
    
    # parse the input constraint file to identify assertions
    open(FILE, "$file") or die "Can't read file $file\n";
    my @assertions = ();
    my $assertion;
    my $isassertion = 0;
    $counter = 0;

    while (<FILE>) {
      if (m/^\(push\)/) {
        $assertion = "";
        $isassertion = 1;
      }
      elsif (m/^\(check-sat\)/) {
        push(@assertions, $assertion);
        $isassertion = 0;
      }
      elsif ($isassertion) {
        $assertion = $_;
      }
    }
    
    close (FILE);
    
    # find "unsat" assertions, and output the corrensponding comment in constraint source file
    my $errors = "";
	#print $str;
    for(split /^/, $str) {
      if (/^sat/) {
        $assert = @assertions[$counter];
        $errors .= $assert;
	    $fail_counter ++;
        $counter ++;
      }
      elsif (/^unsat/) {
        $counter ++;
      }
    }
    if ($errors eq "") {
      print_ok();
    }
    else {
      print_fail();
      print $errors;
    }
  }
}

print "Total: $fail_counter assertions failed\n";

