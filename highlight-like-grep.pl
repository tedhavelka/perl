#!/usr/bin/perl -T
# #!/usr/bin/perl




##======================================================================
##
##  FILE:  highlight-like-grep.pl
##
##
##  PURPOSE:  to provide simple and quick HTML text highlighting,
##    to aid in text based wiki content.
##
##
##  NOTES:  Started on 2016-12-05 by Ted Havelka.
##
##
##
##  REFERENCES:
##
##    *  https://perlmaven.com/how-to-split-a-text-file-line-by-line
##
##    *  http://perldoc.perl.org/functions/sprintf.html
##

=for comment

       %%    a percent sign
       %c    a character with the given number
       %s    a string
       %d    a signed integer, in decimal
       %u    an unsigned integer, in decimal
       %o    an unsigned integer, in octal
       %x    an unsigned integer, in hexadecimal
       %e    a floating-point number, in scientific notation
       %f    a floating-point number, in fixed decimal notation
       %g    a floating-point number, in %e or %f notation


       %X    like %x, but using upper-case letters
       %E    like %e, but using an upper-case "E"
       %G    like %g, but with an upper-case "E" (if applicable)
       %b    an unsigned integer, in binary
       %B    like %b, but using an upper-case "B" with the # flag
       %p    a pointer (outputs the Perl value's address in hexadecimal)
       %n    special: *stores* the number of characters output so far
             into the next argument in the parameter list
       %a    hexadecimal floating point
       %A    like %a, but using upper-case letters


       %i    a synonym for %d
       %D    a synonym for %ld
       %U    a synonym for %lu
       %O    a synonym for %lo
       %F    a synonym for %f



      printf '%2$d %1$d', 12, 34;      # prints "34 12"
      printf '%3$d %d %1$d', 1, 2, 3;  # prints "3 1 1"


      printf '<% d>',  12;   # prints "< 12>"
      printf '<% d>',   0;   # prints "< 0>"
      printf '<% d>', -12;   # prints "<-12>"
      printf '<%+d>',  12;   # prints "<+12>"
      printf '<%+d>',   0;   # prints "<+0>"
      printf '<%+d>', -12;   # prints "<-12>"
      printf '<%6s>',  12;   # prints "<    12>"
      printf '<%-6s>', 12;   # prints "<12    >"
      printf '<%06s>', 12;   # prints "<000012>"
      printf '<%#o>',  12;   # prints "<014>"
      printf '<%#x>',  12;   # prints "<0xc>"
      printf '<%#X>',  12;   # prints "<0XC>"
      printf '<%#b>',  12;   # prints "<0b1100>"
      printf '<%#B>',  12;   # prints "<0B1100>"


      printf '<%+ d>', 12;   # prints "<+12>"
      printf '<% +d>', 12;   # prints "<+12>"

=cut

##
##
##  REFERENCES CONTINUED:
##
##    *  https://perlmaven.com/scope-of-variables-in-perl
##        Talks about scope of 'my variable' when declared outside
##        all curly braced scopes, versus within given scope.  Global-
##        to-file variable can be hidden by variable of same name 
##        declared and defined in a subroutine.
##
##    *  http://perldoc.perl.org/functions/our.html
##        Perl 'our' keyword refers to variables which are already
##        and globally defined in a Perl package.
##
##    *  http://perldoc.perl.org/constant.html
##        Shows syntax 'use constant POUND_DEFINE_LIKE_LABEL => (value);
##
##
##    *  http://alvinalexander.com/perl/perl-read-file-into-array-perl-script
##       @array = <> or @array = <FILE_HANDLE>;
##
##
##    *  https://www.tutorialspoint.com/perl/perl_arrays.htm
##
##
##
##======================================================================




##----------------------------------------------------------------------
##  SECTION - Perl use statements
##----------------------------------------------------------------------

use strict;

use warnings;
# no warnings;

use 5.008;



use constant MAX_ARGS_SUPPORTED => 40;

use constant MINIMUM_ARG_COUNT_NEEDED_TO_ATTEMPT_HIGHLIGHTING => 3;



##----------------------------------------------------------------------
##  SECTION - Perl global variables
##----------------------------------------------------------------------

my $global__flag__show_line_numbers = 0;




##----------------------------------------------------------------------
##  SECTION - Perl subroutines
##----------------------------------------------------------------------

sub usage
{

    print "\n";
    print "Usage:  $0 [filename] [pattern_1] [highlight_color_1] [pattern_2] [highlight_color_2] [...]\n";
    print "  where filename is name of file to read,\n";
    print "  and pattern_1 is first pattern to highlight,\n";
    print "  highlight_color_1 is color to apply to pattern_1 instances,\n";
    print "  additional patterns and highlight colors optional . . .\n";
    print "\n";

}



sub high_light_one_text_pattern
{
##----------------------------------------------------------------------
##  *  https://perlmaven.com/how-to-split-a-text-file-line-by-line
##----------------------------------------------------------------------

    my $caller = shift;
    my $filename = shift;
    my $pattern_1 = shift;
    my $highlight_color_1 = shift;

    my $FILE;
    my $line;
    my $count_of_lines_processed = 0;

    my $tag_for_highlight_1_open = "<font color=\"\">";
    my $tag_for_highlight_1_close = "</font>";



# - STEP - Bounds checking here on passed values:
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    if ( length(...

    open (FILE, $filename) or print "Could not open file '$filename' $!";



# - STEP - build text highlighting tag, and HTML tag to set font color:

    $tag_for_highlight_1_open = "<font color=\"$highlight_color_1\">";



# - STEP - read file and highlight text, line by line:

    $line = <FILE>;    
#    while ( ($line = <FILE>) && (1) )
    while ( ($line ) && (1) )
    {
        $line =~ s/${pattern_1}/${tag_for_highlight_1_open}${pattern_1}${tag_for_highlight_1_close}/g;
#        print "$count_of_lines_processed:  $line";
        printf('%5s:  %s', $count_of_lines_processed, $line);
        $line = <FILE>;    
        ++$count_of_lines_processed;
    }


    printf('closing text file \'%s\' . . .', $filename);
    close (FILE);


} # end subroutine high_light_one_text_pattern





sub high_light_five_text_patterns
{
##----------------------------------------------------------------------
##  *  https://perlmaven.com/how-to-split-a-text-file-line-by-line
##----------------------------------------------------------------------

    my $caller = shift;
    my $filename = shift;
    my $pattern_1 = shift;
    my $highlight_color_1 = shift;
    my $pattern_2 = shift;
    my $highlight_color_2 = shift;
    my $pattern_3 = shift;
    my $highlight_color_3 = shift;
    my $pattern_4 = shift;
    my $highlight_color_4 = shift;
    my $pattern_5 = shift;
    my $highlight_color_5 = shift;

    my $FILE;
    my $line;
    my $count_of_lines_processed = 0;

    my $tag_for_highlight_1_open = "<font color=\"\">";
    my $tag_for_highlight_2_open = "<font color=\"\">";
    my $tag_for_highlight_3_open = "<font color=\"\">";
    my $tag_for_highlight_4_open = "<font color=\"\">";
    my $tag_for_highlight_5_open = "<font color=\"\">";
    my $tag_for_highlight_1_close = "</font>";



    print "<sub>:  about to highlight up to five text patterns in lines of file . . .\n";
    print "\n";



# - STEP - Bounds checking here on passed values:
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    if ( length(...

    open (FILE, $filename) or print "Could not open file '$filename' $!";



# - STEP - build text highlighting tag, and HTML tag to set font color:

    if ( length($highlight_color_1) > 0 )
    {
        $tag_for_highlight_1_open = "<font color=\"$highlight_color_1\">";
    }

    if ( length($highlight_color_2) > 0 )
    {
        $tag_for_highlight_2_open = "<font color=\"$highlight_color_2\">";
    }

    if ( length($highlight_color_3) > 0 )
    {
        $tag_for_highlight_3_open = "<font color=\"$highlight_color_3\">";
    }

    if ( length($highlight_color_4) > 0 )
    {
        $tag_for_highlight_4_open = "<font color=\"$highlight_color_4\">";
    }

    if ( length($highlight_color_5) > 0 )
    {
        $tag_for_highlight_5_open = "<font color=\"$highlight_color_5\">";
    }



# - STEP - read file and highlight text, line by line:

    while ( ($line = <FILE>) && (1) )
    {
        if ( length($highlight_color_1) > 0 )
        {
#            $line =~ s/${pattern_1}/${tag_for_highlight_1_open}${pattern_1}${tag_for_highlight_1_close}/g;
            $line =~ s/(${pattern_1})/${tag_for_highlight_1_open}$1${tag_for_highlight_1_close}/g;
        }

        if ( length($highlight_color_2) > 0 )
        {
#            $line =~ s/${pattern_2}/${tag_for_highlight_2_open}${pattern_2}${tag_for_highlight_1_close}/g;
            $line =~ s/(${pattern_2})/${tag_for_highlight_2_open}$1${tag_for_highlight_1_close}/g;
        }

        if ( length($highlight_color_3) > 0 )
        {
#            $line =~ s/${pattern_3}/${tag_for_highlight_3_open}${pattern_3}${tag_for_highlight_1_close}/g;
            $line =~ s/(${pattern_3})/${tag_for_highlight_3_open}$1${tag_for_highlight_1_close}/g;
        }

        if ( length($highlight_color_4) > 0 )
        {
#            $line =~ s/${pattern_4}/${tag_for_highlight_4_open}${pattern_4}${tag_for_highlight_1_close}/g;
            $line =~ s/(${pattern_4})/${tag_for_highlight_4_open}$1${tag_for_highlight_1_close}/g;
        }

        if ( length($highlight_color_5) gt 0 )
        {
#            $line =~ s/${pattern_5}/${tag_for_highlight_5_open}${pattern_5}${tag_for_highlight_1_close}/g;
            $line =~ s/(${pattern_5})/${tag_for_highlight_5_open}$1${tag_for_highlight_1_close}/g;
        }

#        print "$count_of_lines_processed:  $line";
        printf('%5s:  %s', $count_of_lines_processed, $line);
        ++$count_of_lines_processed 
    }


    print "\n";
    printf('<sub>:  closing text file \'%s\' . . .\n', $filename);
    close (FILE);


} # end subroutine high_light_five_text_patterns





sub apply_present_highlight
{
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##
##  2017-02-20 MON - this routine started - TMH
##
##    *  http://docstore.mik.ua/orelly/perl/cookbook/ch10_10.htm   . . . returning multiple arrays and hashes,
##
##    *  https://perlmaven.com/perl-arrays    . . . Perl foreach construct to iterate over array elements,
##
##    *  http://perldoc.perl.org/functions/chop.html
##
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# calling code identifier:
    my $caller = shift;

# array of lines from text file to parse and highlight:
    my $ref_to_array_of_lines = shift;

# . . .
    my $pattern = shift;

# . . .
    my $highlight_color = shift;


    my $line;

    my $tag_for_highlight__open = "";

    my $tag_for_highlight__close = "";



# diagnostics:
    my $rname = "apply_present_highlight";



    printf("%s:  starting,\n", $rname);


#    $line = $ref_to_array_of_lines->[0];
#    chop($line);
#    printf("%s:  received array of lines with line one holding '%s',\n", $rname, $line);
#
#    $line = $ref_to_array_of_lines->[1];
#    chop($line);
#    printf("%s:  received array of lines with line two holding '%s',\n", $rname, $line);
#
#    $line = $ref_to_array_of_lines->[2];
#    chop($line);
#    printf("%s:  received array of lines with line three holding '%s',\n", $rname, $line);


    printf("%s:  received pattern '%s' to search for and highlight,\n", $rname, $pattern);

    printf("%s:  received highlight color '%s',\n", $rname, $highlight_color);


    $tag_for_highlight__open = "<font color=\"$highlight_color\">";
    $tag_for_highlight__close = "</font>";

    foreach $line (@$ref_to_array_of_lines)
    {

        $line =~ s/(${pattern})/${tag_for_highlight__open}$1${tag_for_highlight__close}/g;

#        printf("   '%s'\n", $line);

    }


    printf("%s:  returning to caller . . .\n", $rname);

    return $ref_to_array_of_lines;

}





sub high_light_n_text_patterns
{



# calling code identifier:
    my $caller = shift;

# name of text file to open, parse, and generate HTML highlighted versions of its lines:
    my $filename = shift;

# local count of arguments passed to this Perl script:
    my $argc = @ARGV;

# local index to control and limit loop constructs:
    my $i = 0;

# local counter to keep tally of patterns searched for:
    my $patterns_searched_for;


# local file handle for connection to text file to parse:
    my $FILE;

# local flag to indicate whether text file opened successfully for parsing:
    my $flag__opened_text_file = 0;

# local array to hold lines of text from file to parse, NEED TO SET BOUNDS ON NUMBER OF LINES READ - TMH:
    my @lines;

# local string to hold given line from text file to parse:
    my $line;


# diagnostics:
    my $rname = "high_light_n_text_patterns";


    print $rname . ":  starting,\n";

    printf("%s:  received %d arguments,\n", $rname, $argc);




# 2017-02-20 MON - DEVELOPMENT CODE:

    if ( 0 )
    {
        while (( $ARGV[$i] ) && ( $i < MAX_ARGS_SUPPORTED ))
        {
            printf("%s:  ARGV[%d] holds '%s',\n", $rname, $i, $ARGV[$i]);
            ++$i;
        }
    }



## - STEP - check that there are at least two more arguments passed

    if ( $argc >= MINIMUM_ARG_COUNT_NEEDED_TO_ATTEMPT_HIGHLIGHTING )
    {
        printf("%s:  opening text file '%s' . . .\n", $rname, $filename);
#        open (FILE, $filename) or print "Could not open file '$filename' $!";
        $flag__opened_text_file = open (FILE, $filename) or print "Could not open file '$filename' $!";

        if ( $flag__opened_text_file == 0 )
        {
#            $flag__opened_text_file = 1;
            printf("%s:  call to Perl open() of file handle returns 'success' value,\n");
            printf("%s:  assigned return value of open() to variable \$flag__opened_text_file, which now holds %d,\n",
              $rname, $flag__opened_text_file);
        }
        else
        {
            printf("%s:  \$FILE evaulates to 'false',\n", $rname);
            printf("%s:  assigned return value of open() to variable \$flag__opened_text_file, which now holds %d,\n",
              $rname, $flag__opened_text_file);

            @lines = <FILE>;
        }
    }
    else
    {
        printf("%s:  did not get enough arguments when invoked, to open and highlight text patterns in a file!\n",
          $rname);
    }



## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## Note - per usage this Perl script expects a filename argument from
##  the invoking user or program at $ARGV[0].  Text patterns to search
##  for and highlight begin at $ARGV[1].  Patterns and highlight
##  colors come in pairs, per the expected usage design of this
##  script.  - TMH
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ( $flag__opened_text_file )
    {
        $i = 1;

        $patterns_searched_for = 0;

        while (( $ARGV[$i] ) && ( $i < MAX_ARGS_SUPPORTED ))
        {

## - STEP - check that there are at least two more arguments passed
##    to this script, arguments which should be a pattern to match
##    and a color to highlight any matches:


            if ( $ARGV[($i + 1)] )
            {
                ++$patterns_searched_for;

                printf("%s:  text pattern %d holds '%s', will highlight in '%s',\n",
                  $rname, $patterns_searched_for, $ARGV[$i], $ARGV[($i + 1)]);


## - STEP - parse and apply latest highlight to present text pattern:

                printf("\n");
                printf("%s:  - TEST 1 -\n", $rname);
#                printf("%s:  \@lines has %d elements,\n", $rname, (scalar @lines));
#                printf("%s:  \@lines element one holds '%s',\n", $rname, $lines[0]);
#                printf("%s:  \@lines element two holds '%s',\n", $rname, $lines[1]);
                printf("%s:  calling with argument 2 set to \\\@lines . . .\n", $rname);
                apply_present_highlight($rname, \@lines, $ARGV[$i], $ARGV[($i + 1)]);

                ++$i; ++$i;
            }
            else
            {
                printf("%s:  reached end of pattern plus highlight color argument pairs,\n", $rname);
            }

        } # . . . end WHILE-loop to process pattern-plus-highlight-color argument pairs

        print "\n";
        printf("%s:  closing text file '%s' . . .\n", $rname, $filename);
        close (FILE);

    } # . . . end IF statement to test whether text file opened successfully

    else
    {
        printf("%s:  no text file opened to parse and highlight so skipping parsing loop,\n",
          $rname);
    }



## - STEP - send file lines modified and not modified to standard out:

    if ( $flag__opened_text_file )
    {
        printf("%s:  back from all highlighting, array of lines from text file holds:\n\n", $rname);

        foreach $line (@lines)
        {
            printf("   '%s'\n", $line);

        }

        printf("\n");
    }



# - STEP -

    if ( $flag__opened_text_file )
    {
        my $basename = basename($filename, {".*"});

        printf("%s:  basename of file just parsed and highlighted is '%s',\n", $rname, $basename);
    }



#    printf("\n");
    printf("%s:  returning to calling code . . .\n", $rname);


} # end sub high_light_n_text_patterns








##----------------------------------------------------------------------
## - SECTION - main line code
##----------------------------------------------------------------------

{

    my $argc;
    my $filename = $ARGV[0];
    my $pattern_1_to_highlight = $ARGV[1];
    my $highlight_color_1 = $ARGV[2];
    my $flag__show_usage = 0;



    print "starting,\n";

    $argc = @ARGV;
    printf("received %d arguments,\n", $argc);



    if ( length($filename) > 0 )
    {
        print "received filename to parse, filename is '$filename',\n";
    }
    else
    {
        print "Warning - received no name of file to parse!\n";
        $flag__show_usage = 1;
    }

    if ( length($pattern_1_to_highlight) > 0 )
    {
       print "received first pattern to highlight, it is '$pattern_1_to_highlight'\n";
    }
    else
    {
        print "Warning - received no pattern to highlight!\n";
        $flag__show_usage = 1;
    }


    if ( length($highlight_color_1) > 0 )
    {
       print "received color of first highlight pattern '$highlight_color_1'\n";
    }
    else
    {
        print "Warning - received no color for highlight pattern 1!\n";
        $flag__show_usage = 1;
    }


    if ( $flag__show_usage )
    {
        usage();
    }



# - STEP - Check number of command line arguments, and select a highlighting
#          routine based on this number:


#    if ( $argc < 4 )
    if ( 1 )
    {
#        print "calling routine to highlight one text pattern . . .\n";
        print "calling new routine to highlight n text patterns . . .\n";

#        high_light_one_text_pattern("main", $filename, "CRC", "red");
#        high_light_one_text_pattern("main", $filename, $ARGV[1], $ARGV[2]);
        high_light_n_text_patterns("main", $filename);

    }
    else
    {
        print "calling routine to highlight between one and five text patterns . . .\n";
        high_light_five_text_patterns("main",
          $ARGV[0],                   # the name of text file to read and highlight select text,
          $ARGV[1], $ARGV[2],         # pattern 1, highlight color 1,
          $ARGV[3], $ARGV[4],         # pattern 2, highlight color 2,
          $ARGV[5], $ARGV[6],         # pattern 3, highlight color 3,
          $ARGV[7], $ARGV[8],         # pattern 4, highlight color 4,
          $ARGV[9], $ARGV[10]         # pattern 5, highlight color 5,
        );
    }



    print "done.\n\n";


}



# --- EOF ---
