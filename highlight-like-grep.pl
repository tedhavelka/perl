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
##
##
##
##
##
##
##
##
##
##======================================================================


use strict;
use warnings;
# no warnings;
use 5.008;

## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -




sub usage
{
    print "Usage:  $0 [filename] [pattern_1] [highlight_color_1] [pattern_2] [highlight_color_2] [...]\n";
    print "  where filename is name of file to read,\n";
    print "  and pattern_1 is first pattern to highlight,\n";
    print "  highlight_color_1 is color to apply to pattern_1 instances,\n";
    print "  additional patterns and highlight colors optional . . .\n";

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
        print "Warning - received no name of fil to parse!\n";
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


    if ( $flag__show_usage)
    {
        usage();
    }



# - STEP - Check number of command line arguments, and select a highlighting
#          routine based on this number:

    $argc = @ARGV;

    printf("received %d arguments,\n", $argc);

    if ( $argc < 4 )
    {
        print "calling routine to highlight one text pattern . . .\n";
#        high_light_one_text_pattern("main", $filename, "CRC", "red");
        high_light_one_text_pattern("main", $filename, $ARGV[1], $ARGV[2]);
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
