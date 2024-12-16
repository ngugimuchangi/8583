#--
# Copyright 2009 by Tim Becker (tim.becker@kuriostaet.de)
# MIT License, for details, see the LICENSE file accompaning
# this distribution
#++

module ISO8583

  # This file contains a number of preinstantiated Field definitions. You
  # will probably need to create own fields in your implementation, please
  # see Field and Codec for further discussion on how to do this.
  # The fields currently available are those necessary to implement the 
  # Berlin Groups Authorization Spec.
  #
  # The following fields are available:
  #
  # [+LL+]           special form to de/encode variable length indicators, two bytes ASCII numerals
  # [+LLL+]          special form to de/encode variable length indicators, two bytes ASCII numerals
  # [+LL_BCD+]       special form to de/encode variable length indicators, two BCD digits
  # [+LLVAR_N+]      two byte variable length ASCII numeral, payload ASCII numerals
  # [+LLLVAR_N+]     three byte variable length ASCII numeral, payload ASCII numerals
  # [+LLVAR_Z+]      two byte variable length ASCII numeral, payload Track2 data 
  # [+LLVAR_AN+]    two byte variable length ASCII numeral, payload ASCII
  # [+LLVAR_ANS+]    two byte variable length ASCII numeral, payload ASCII+special
  # [+LLLVAR_AN+]   three byte variable length ASCII numeral, payload ASCII
  # [+LLLVAR_ANS+]   three byte variable length ASCII numeral, payload ASCII+special
  # [+LLVAR_B+]      Two byte variable length binary payload
  # [+LLLVAR_B+]     Three byte variable length binary payload
  # [+A+]            fixed length letters, represented in ASCII
  # [+N+]            fixed lengh numerals, repesented in ASCII, padding right justified using zeros
  # [+AN+]          fixed lengh ASCII [A-Za-z0-9], padding left justified using spaces.
  # [+ANP+]          fixed lengh ASCII [A-Za-z0-9] and space, padding left, spaces
  # [+ANS+]          fixed length ASCII  [\x20-\x7E], padding left, spaces
  # [+B+]            binary data, padding left using nulls (0x00)
  # [+MMDDhhmmss+]   Date, formatted as described in ASCII numerals
  # [+MMDD+]         Date, formatted as described in ASCII numerals
  # [+YYMMDDhhmmss+] Date, formatted as named in ASCII numerals
  # [+YYMM+]         Expiration Date, formatted as named in ASCII numerals
  # [+Hhmmss+]       Date, formatted in ASCII hhmmss


  # Special form to de/encode variable length indicators, two bytes ASCII numerals 
  LL         = Field.new
  LL.name    = "LL"
  LL.length  = 2
  LL.codec   = ASCII_Number
  LL.padding = lambda {|value|
    sprintf("%02d", value)
  }
  # Special form to de/encode variable length indicators, three bytes ASCII numerals
  LLL         = Field.new
  LLL.name    = "LLL"
  LLL.length  = 3
  LLL.codec   = ASCII_Number
  LLL.padding = lambda {|value|
    sprintf("%03d", value)
  }

  # Special form to de/encode variable length indicators, six bytes ASCII numerals
  LLLLLL         = Field.new
  LLLLLL.name    = "LLLLLL"
  LLLLLL.length  = 6
  LLLLLL.codec   = ASCII_Number
  LLLLLL.padding = lambda {|value|
    sprintf("%06d", value)
  }

  LL_BCD        = BCDField.new
  LL_BCD.name   = "LL_BCD"
  LL_BCD.length = 2
  LL_BCD.codec  = Packed_Number

  # Two byte variable length ASCII numeral, payload ASCII numerals
  LLVAR_N        = Field.new
  LLVAR_N.name   = "LLVAR_N"
  LLVAR_N.length = LL
  LLVAR_N.codec  = ASCII_Number

  # Three byte variable length ASCII numeral, payload ASCII numerals
  LLLVAR_N        = Field.new
  LLLVAR_N.name   = "LLLVAR_N"
  LLLVAR_N.length = LLL
  LLLVAR_N.codec  = ASCII_Number

  # Two byte variable length ASCII numeral, payload Track2 data
  LLVAR_Z         = Field.new
  LLVAR_Z.name    = "LLVAR_Z"
  LLVAR_Z.length  = LL
  LLVAR_Z.codec   = Track2

  # Two byte variable length ASCII numeral, payload ASCII, fixed length, zeropadded (right)
  LLVAR_AN        = Field.new
  LLVAR_AN.name   = "LLVAR_AN"
  LLVAR_AN.length = LL
  LLVAR_AN.codec  = AN_Codec

  # Two byte variable length ASCII numeral, payload ASCII+special
  LLVAR_ANS        = Field.new
  LLVAR_ANS.name   = "LLVAR_ANS"
  LLVAR_ANS.length = LL
  LLVAR_ANS.codec  = ANS_Codec

  # Three byte variable length ASCII numeral, payload ASCII, fixed length, zeropadded (right)
  LLLVAR_AN        = Field.new
  LLLVAR_AN.name   = "LLLVAR_AN"
  LLLVAR_AN.length = LLL
  LLLVAR_AN.codec  = AN_Codec

  # Three byte variable length ASCII numeral, payload ASCII+special
  LLLVAR_ANS        = Field.new
  LLLVAR_ANS.name   = "LLLVAR_ANS"
  LLLVAR_ANS.length = LLL
  LLLVAR_ANS.codec  = ANS_Codec


  # Six byte variable length ASCII numeral, payload ASCII+special
  LLLLLLVAR_ANS        = Field.new
  LLLLLLVAR_ANS.name   = "LLLLLLVAR_ANS"
  LLLLLLVAR_ANS.length = LLLLLL
  LLLLLLVAR_ANS.codec  = ANS_Codec

  # Two byte variable length binary payload
  LLVAR_B        = Field.new
  LLVAR_B.name   = "LLVAR_B"
  LLVAR_B.length = LL
  LLVAR_B.codec  = Null_Codec


  # Three byte variable length binary payload
  LLLVAR_B        = Field.new
  LLLVAR_B.name   = "LLLVAR_B"
  LLLVAR_B.length = LLL
  LLLVAR_B.codec  = Null_Codec

  # Encoded as ASCII_NUM_STR, this field may contain a variable-length (0-99) digits,
  # but it should be treated as a string and not used for arithmetic operations.
  LLVAR_N_STR = Field.new
  LLVAR_N_STR.name = "LLVAR_N_STR"
  LLVAR_N_STR.length = LL
  LLVAR_N_STR.codec = ASCII_NUM_STR

  #  Encoded as ASCII_NUM_STR, this field may contain a variable-length (0-999) digits,
  # but it should be treated as a string and not used for arithmetic operations.
  LLLVAR_N_STR = Field.new
  LLLVAR_N_STR.name = "LLLVAR_N_STR"
  LLLVAR_N_STR.length = LLL
  LLLVAR_N_STR.codec = ASCII_NUM_STR

  # Fixed lengh numerals, repesented in ASCII, padding right justified using zeros
  N = Field.new
  N.name  = "N"
  N.codec = ASCII_Number
  N.padding = lambda {|val, len|
    sprintf("%0#{len}d", val)
  }

  # Encoded as ASCII_XN, this field should start with letters (C or D) followed by digits.
  # It represents a specific format that combines both character sets.
  XN = Field.new
  XN.name = "XN"
  XN.codec = ASCII_XN
  XN.padding = lambda {|val, len|
    prefix = val[0]
    num = val[1, len - 1]
    format("%s%0#{len - 1}d", prefix, num)
  }

  # Encoded as ASCII_NUM_STR, this field may contain digits,
  # but it should be treated as a string and not used for arithmetic operations.
  N_STR = Field.new
  N_STR.name = "N_STR"
  N_STR.codec = ASCII_NUM_STR
  N_STR.padding = lambda {|val, len|
    sprintf("%0#{len}s", val)
  }

  N_BCD = BCDField.new
  N_BCD.name  = "N_BCD"
  N_BCD.codec = Packed_Number

  PADDING_LEFT_JUSTIFIED_SPACES = lambda {|val, len|
    sprintf "%-#{len}s", val
  }

  # Fixed length ASCII letters [A-Za-z]
  A = Field.new
  A.name  = "A"
  A.codec = A_Codec

  # Fixed lengh ASCII [A-Za-z0-9], padding left justified using spaces.
  AN = Field.new
  AN.name  = "AN"
  AN.codec = AN_Codec
  AN.padding = PADDING_LEFT_JUSTIFIED_SPACES

  # Fixed lengh ASCII [A-Za-z0-9] and space, padding left, spaces
  ANP = Field.new
  ANP.name  = "ANP"
  ANP.codec = ANP_Codec
  ANP.padding = PADDING_LEFT_JUSTIFIED_SPACES

  # Fixed length ASCII  [\x20-\x7E], padding left, spaces
  ANS = Field.new
  ANS.name = ANS
  ANS.codec = ANS_Codec
  ANS.padding = PADDING_LEFT_JUSTIFIED_SPACES

  # Binary data, padding left using nulls (0x00)
  B = Field.new
  B.name  = "B"
  B.codec = Null_Codec
  B.padding = lambda {|val, len|
    while val.length < len
      val = val + "\000"
    end
    val
  }

  # Date, formatted as described in ASCII numerals
  MMDDhhmmss        = Field.new
  MMDDhhmmss.name   = "MMDDhhmmss"
  MMDDhhmmss.codec  = MMDDhhmmssCodec
  MMDDhhmmss.length = 10

  #Date, formatted as described in ASCII numerals
  YYMMDDhhmmss        = Field.new
  YYMMDDhhmmss.name   = "YYMMDDhhmmss"
  YYMMDDhhmmss.codec  = YYMMDDhhmmssCodec
  YYMMDDhhmmss.length = 12

  #Date, formatted as described in ASCII numerals
  YYMM        = Field.new
  YYMM.name   = "YYMM"
  YYMM.codec  = YYMMCodec
  YYMM.length = 4
  
  MMDD        = Field.new
  MMDD.name   = "MMDD"
  MMDD.codec  = MMDDCodec
  MMDD.length = 4

  Hhmmss        = Field.new
  Hhmmss.name   = "Hhmmss"
  Hhmmss.codec  = HhmmssCodec
  Hhmmss.length = 6

end
