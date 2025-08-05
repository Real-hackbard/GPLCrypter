object Form1: TForm1
  Left = 1714
  Top = 314
  Width = 529
  Height = 498
  Caption = 'GPL Crypter 1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 135
    Width = 497
    Height = 298
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Crypt File'
      ImageIndex = 1
      object Label8: TLabel
        Left = 16
        Top = 8
        Width = 265
        Height = 33
        AutoSize = False
        Caption = 
          'Demo encrypt && decrypt of stream.'#13'Select file && click on "Encr' +
          'ypt.." or "Decrypt..." button.'
        Transparent = True
        WordWrap = True
      end
      object StrmEncryptMsg: TLabel
        Left = 16
        Top = 96
        Width = 457
        Height = 113
        AutoSize = False
        Transparent = True
        WordWrap = True
      end
      object Button3: TButton
        Left = 16
        Top = 216
        Width = 97
        Height = 25
        Caption = 'Encrypt Stream'
        TabOrder = 0
        OnClick = Button3Click
      end
      object Button6: TButton
        Left = 121
        Top = 216
        Width = 96
        Height = 25
        Caption = 'Decrypt Stream'
        TabOrder = 1
        OnClick = Button6Click
      end
      object StrmFile: TEdit
        Left = 16
        Top = 40
        Width = 457
        Height = 21
        TabOrder = 2
        Text = 'any file..'
      end
      object Button7: TButton
        Left = 16
        Top = 64
        Width = 97
        Height = 25
        Caption = 'Browse'
        TabOrder = 3
        OnClick = Button7Click
      end
      object ProgressBar1: TProgressBar
        Left = 16
        Top = 248
        Width = 457
        Height = 17
        Smooth = True
        Step = 1
        TabOrder = 4
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Crypt Text'
      object Label6: TLabel
        Left = 3
        Top = 2
        Width = 37
        Height = 13
        Caption = 'Source:'
      end
      object Label7: TLabel
        Left = 3
        Top = 146
        Width = 62
        Height = 13
        Caption = 'Result(text):'
      end
      object Label5: TLabel
        Left = 3
        Top = 127
        Width = 74
        Height = 13
        Caption = 'Encode format:'
      end
      object TxtSource: TMemo
        Left = 3
        Top = 16
        Width = 398
        Height = 97
        Lines.Strings = (
          'Classes unit'
          ''
          'A new exception class, EFileStreamError, has been added.  '
          
            'EFileStreamError and EFOpenError descend from this class. This n' +
            'ew '
          'class may take a FileName parameter. As a result, the exception '
          
            'message text now contains the name of the file the error occurre' +
            'd on.'
          #9'The TStrings class has two new properties, ValueFromIndex '
          'and NameValueSeparator.'
          #9'The TThread.CheckThreadError methods have been '
          'promoted from private to protected visibility.'
          ''
          'Math unit'
          ''
          'The Math unit has a new default parameter, RaisePending, in the '
          'ClearExceptions procedure.'
          ''
          'StdConvs unit'
          ''
          
            'The StdConvs unit now includes stones in the supported weight un' +
            'its.'
          ''
          'StrUtils unit'
          ''
          
            'The StrUtils unit contains the following changes related to mult' +
            'i-byte '
          'character set (MBCS) support:'
          ''
          
            'Previously, LeftStr, RightStr, and MidStr each had an AnsiString' +
            ' '
          
            'parameter type and return type, and did not support MBCS strings' +
            '.  '
          
            'Each of these functions has been replaced by a pair of overloade' +
            'd '
          
            'functions, one that takes and returns AnsiString, and one that t' +
            'akes '
          'and returns WideString. The new functions correctly handle MBCS '
          
            'strings. This change breaks code that uses these functions to st' +
            'ore '
          
            'and retrieve byte values in AnsiStrings. Such code should be upd' +
            'ated '
          'to use the new byte-level functions described below.'
          ''
          
            'New functions LeftBStr, RightBStr, and MidBStr provide the byte-' +
            'level '
          
            'manipulation previously provided by LeftStr, RightStr, and MidSt' +
            'r. '
          #9'New functions AnsiLeftStr, AnsiRightStr, and AnsiMidStr are '
          
            'the same as the new AnsiStr LeftStr, RightStr, and MidStr functi' +
            'ons, '
          'except that they are not overloaded with equivalent WideString '
          'functions. '
          ''
          
            'The StrUtils unit has a new string-searching function called Pos' +
            'Ex.'
          ''
          'SysUtils unit'
          ''
          
            'The SysUtils unit now includes thread-safe overloads of routines' +
            ' that '
          
            'format and parse numbers, date-time values, and currency. The ne' +
            'w '
          'routines are thread-safe because they obtain their localization '
          
            'information from a TFormatSettings data structure instead of fro' +
            'm '
          
            'global variables. This data structure must be populated before b' +
            'eing '
          'used; a new function, GetLocaleFormatSettings, is provided to '
          'populate the data structure from a specified locale.'
          ''
          'VarCmplx unit'
          ''
          'The VarCmplx unit has new functions: VarComplexLog2, '
          'VarComplexLog10, VarComplexLogN, VarComplexTimesImaginary, and '
          'VarComplexTimesReal.'
          ''
          'Variants unit'
          ''
          'The VarIsError and VarAsError functions have been added.'
          #9'The EVariantError exception is now a base class for finer '
          'grained exception classes that are thrown from variants code.'
          #9'Several new global Variant control variables have been '
          'added: NullEqualityRule, NullMagnitudeRule, NullStrictConvert, '
          'NullAsStringValue, and PackVarCreation.')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object TxtEncrypt: TMemo
        Left = 3
        Top = 165
        Width = 398
        Height = 102
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object btnTxtEncrypt: TButton
        Left = 408
        Top = 13
        Width = 73
        Height = 25
        Caption = 'Encrypt'
        TabOrder = 2
        OnClick = btnTxtEncryptClick
      end
      object Button1: TButton
        Left = 408
        Top = 165
        Width = 73
        Height = 25
        Caption = 'Decrypt'
        TabOrder = 3
        OnClick = Button1Click
      end
      object cbxFormat: TComboBox
        Left = 83
        Top = 125
        Width = 97
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
      object Button4: TButton
        Left = 408
        Top = 40
        Width = 73
        Height = 25
        Caption = 'Text Sign'
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 408
        Top = 192
        Width = 73
        Height = 25
        Caption = 'Sign Verify'
        TabOrder = 6
        OnClick = Button5Click
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 177
    Height = 121
    Caption = ' Passphrase '
    TabOrder = 1
    object Label1: TLabel
      Left = 14
      Top = 16
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object Label3: TLabel
      Left = 16
      Top = 67
      Width = 99
      Height = 13
      Caption = 'Length of Password:'
    end
    object TxtPwd: TEdit
      Left = 14
      Top = 35
      Width = 147
      Height = 21
      TabOrder = 0
      Text = 'Password'
    end
    object TxtPwdLength: TEdit
      Left = 119
      Top = 64
      Width = 41
      Height = 21
      MaxLength = 2
      TabOrder = 1
      Text = '16'
    end
    object Button2: TButton
      Left = 14
      Top = 86
      Width = 75
      Height = 25
      Caption = 'Generate'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 192
    Top = 8
    Width = 177
    Height = 121
    Caption = ' Crypt Modes '
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 50
      Height = 13
      Caption = 'CipherAlg:'
    end
    object Label4: TLabel
      Left = 16
      Top = 76
      Width = 28
      Height = 13
      Caption = 'Hash:'
    end
    object cbxCipher: TComboBox
      Left = 16
      Top = 52
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object cbxHash: TComboBox
      Left = 16
      Top = 92
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 440
    Width = 513
    Height = 19
    Panels = <>
  end
end
