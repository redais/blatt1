#!/usr/bin/env ruby

# x ist das auf einen vollen Euro-Betrag
# abgerundete zu versteuernde Einkommen.


# y ist ein Zehntausendstel des 8 004 Euro übersteigenden Teils
# des auf einen vollen Euro-Betrag abgerundeten zu versteuernden Einkommens.


# z ist ein Zehntausendstel des 13 469 Euro übersteigenden Teils des auf einen vollen Euro-Betrag
#abgerundeten zu versteuernden Einkommens

# Nullzone => 0
# Progresionszone 1 => (912.17*y+1400)*y
# Progresionszone 2 => (228.74*z+2397)*z
# Proportionalzone 1 => (0.42*x)-8172
#Proportionalzone 2 (Reichensteuer)=>0.45*x-15694

usage =<<HERE
Usage:  01-ekstueuer.rb <zvE> [<zvE2>] [<zvE_increment>]

HERE

raise usage if ARGV.size != 1 && ARGV.size != 2 && ARGV.size != 3

x=y=z=0
def ek_steuer(zve)
   
    x=zve.to_i
    if(x>8004)
        y=((x.to_f-8004)/10000)
    end
    if(x>13469)
        z=((x.to_f-13469)/10000)
    end
   
    # Nullzone
    if (x<=8004)
       return  0.0
    #progression zone 1
    elsif x<=13469
        return ((912.17*y+1400)*y)
        
    elsif x<=52881
        return((228.74*z+2397)*z+1038)
    elsif x<=250730 
        return 0.42*x-8172
    else
        return 0.45*x-15694
    end
    
    
end

def grenzsteuersatz(zve)
    zve=zve.to_f
    if (zve<8004)
        return 0
    elsif (zve==8004)
        return 0.14
    elsif (zve<=13470)
        return ((0.24-0.14)/(13470-8004))*(zve-13470)+0.24
    elsif (zve<=52882)
        return ((0.42-0.24)/(52882-13470))*(zve-52882)+0.42
    elsif (zve<=250730)
        return 0.42
    else
        return 0.45
    end
end

puts ek_steuer(ARGV[0])
puts grenzsteuersatz(ARGV[0])


