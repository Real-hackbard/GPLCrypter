unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,GP_Intrf, GP_Wrapper;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TxtSource: TMemo;
    TxtEncrypt: TMemo;
    Button3: TButton;
    Button6: TButton;
    Label6: TLabel;
    Label7: TLabel;
    btnTxtEncrypt: TButton;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    TxtPwd: TEdit;
    TxtPwdLength: TEdit;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    cbxCipher: TComboBox;
    cbxHash: TComboBox;
    cbxFormat: TComboBox;
    Label5: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label8: TLabel;
    StrmFile: TEdit;
    Button7: TButton;
    StrmEncryptMsg: TLabel;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnTxtEncryptClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    FWrap:TLibGPWrapper;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
var
  CiphersList: array[0..15] of record Name:String; Cipher:TGPCipherAlgorithm end = (
    (Name:'Blowfish';Cipher:caBlowfish),
    (Name:'Twofish';Cipher:caTwofish),
    (Name:'IDEA';Cipher:caIDEA),
    (Name:'Cast128';Cipher:caCast128),
    (Name:'Cast256';Cipher:caCast256),
    (Name:'RC2';Cipher:caRC2),
    (Name:'RC4';Cipher:caRC4),
    (Name:'RC5';Cipher:caRC5),
    (Name:'RC6';Cipher:caRC6),
    (Name:'Rijndael';Cipher:caRijndael),
    (Name:'Square';Cipher:caSquare),
    (Name:'SCOP';Cipher:caSCOP),
    (Name:'Sapphire';Cipher:caSapphire),
    (Name:'Gost';Cipher:caGost),
    (Name:'TEA';Cipher:caTEA),
    (Name:'TEAN';Cipher:caTEAN));
  HashList: array[0..13] of record Name:String; Hash:TGPHashType end = (
    (Name:'MD4';Hash:htMD4),
    (Name:'MD5';Hash:htMD5),
    (Name:'SHA';Hash:htSHA),
    (Name:'SHA256';Hash:htSHA256),
    (Name:'SHA512';Hash:htSHA512),
    (Name:'Sapphire';Hash:htSapphire),
    (Name:'RipeMD128';Hash:hRipeMD128),
    (Name:'RipeMD256';Hash:htRipeMD256),
    (Name:'Haval128';Hash:htHaval128),
    (Name:'Haval256';Hash:htHaval256),
    (Name:'Whirlpool';Hash:htWhirlpool),
    (Name:'Square';Hash:htSquare),
    (Name:'Snefru128';Hash:htSnefru128),
    (Name:'Snefru256';Hash:htSnefru256));
  FormatList: array[0..3] of record Name:String; Format:TGPFormat end =(
    (Name:'Hex';Format:fHex),
    (Name:'Mime32';Format:fMime32),    
    (Name:'Mime64';Format:fMime64),
    (Name:'PGP Style';Format:fPGP));
{$R *.dfm}

procedure TForm1.btnTxtEncryptClick(Sender: TObject);
var
  A:PChar;
  HLib:THandle;
  HProc:function(const AText,APassword: PChar; const ACipher:TGPCipherAlgorithm;
    AHash: TGPHashType; AFormat:TGPFormat; var ATextOut:PChar):Integer;stdcall;
begin
  {A:=StrAlloc(Length(TxtSource.Text) * 5);
  FWrap.EncryptText(PChar(TxtSource.Text),PChar(TxtPwd.Text),
    TGPCipherAlgorithm(cbxCipher.Items.Objects[cbxCipher.ItemIndex]),
    TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
    TGPFormat(cbxFormat.Items.Objects[cbxFormat.ItemIndex]),A);
  TxtEncrypt.Text := A;
  StrDispose(A);}

  A:=StrAlloc(Length(TxtSource.Text) * 5);
  if FileExists('GPLib.dll') then begin
    HLib := LoadLibrary('GPLib.dll');
    if HLib > 0 then begin
      @HProc := GetProcAddress(HLib,'GPEncryptText');
      if @HProc <> nil then
      HProc(PChar(TxtSource.Text),PChar(TxtPwd.Text),
        TGPCipherAlgorithm(cbxCipher.Items.Objects[cbxCipher.ItemIndex]),
        TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
        TGPFormat(cbxFormat.Items.Objects[cbxFormat.ItemIndex]),A);
      FreeLibrary(HLib);
    end;
  end;
  TxtEncrypt.Text := A;
  StrDispose(A);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  A:PChar;
begin
  A:=StrAlloc(Length(TxtEncrypt.Text) * 2);
  FWrap.DecryptText(PChar(TxtEncrypt.Text),PChar(TxtPWd.Text),
  TGPCipherAlgorithm(cbxCipher.Items.Objects[cbxCipher.ItemIndex]),
  TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
  TGPFormat(cbxFormat.Items.Objects[cbxFormat.ItemIndex]),A);
  TxtEncrypt.Text := A;
  StrDispose(A);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  HLib:THandle;
  HProc:procedure(var Buffer:PChar;Size:Integer);stdcall;
  HBuffer:PChar;
begin
  {TxtPwd.Text := FWrap.RandomStr(StrToInt(TxtPwdLength.Text));}
  
  if FileExists('GPLib.dll') then begin
    HBuffer := StrAlloc(StrToInt(TxtPwdLength.Text) * 2);
    HLib := LoadLibrary('GPLib.dll');
    if HLib > 0 then begin
      @HProc := GetProcAddress(HLib,'GPRandomStr');
      if @HProc <> nil then HProc(HBuffer,StrToInt(TxtPwdLength.Text));
      TxtPwd.Text := HBuffer;
      StrDispose(HBuffer);
      FreeLibrary(HLib);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I:Integer;
begin
  FWrap:=TLibGPWrapper.Create('GPLib.dll');
  
  for I:=0 to High(CiphersList) do
  cbxCipher.Items.AddObject(CiphersLIst[I].Name,TObject(CiphersList[I].Cipher));
  cbxCipher.ItemIndex := 0;

  for I:=0 to High(HashList) do
  cbxHash.Items.AddObject(HashList[I].Name,TObject(HashList[I].Hash));
  cbxHash.ItemIndex := 0;

  for I:=0 to High(FormatList) do
  cbxFormat.Items.AddObject(FormatList[I].Name,TObject(FormatList[I].Format));
  cbxFormat.ItemIndex := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FWrap.Destroy;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Strm,Strm2:TStream;
  AFile,AFileEncrypt:String;
  HLib:THandle;
  HProc:function(const APassword: PChar; const ACipher:TGPCipherAlgorithm;
    AHash: TGPHashType; const ASource, ADest: TStream;
    const OnProgress: TGPNotify_Progress = nil):Integer;stdcall;
begin
  ProgressBar1.Position := 0;
  StrmEncryptMsg.Caption := '';
  Strm := TMemoryStream.Create;
  Strm2 := TMemoryStream.Create;
  try
    AFile := StrmFile.Text;
    AFileEncrypt := ChangeFileExt(AFile,'.enc')+ExtractFileExt(AFile);
    (Strm as TMemoryStream).LoadFromFile(AFile);
    Strm.Position := 0;
    
    {FWrap.EncryptStream(PChar(TxtPWd.Text),
      TGPCipherAlgorithm(cbxCipher.Items.Objects[cbxCipher.ItemIndex]),
      TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
      TGPFormat(cbxFormat.Items.Objects[cbxFormat.ItemIndex]),Strm,Strm2);}

      if FileExists(ExtractFilePath(Application.ExeName)+'\GPLib.dll') then begin
        HLib := LoadLibrary(Pchar(ExtractFilePath(Application.ExeName)+'GPLib.dll'));
        if HLib > 0 then begin
          @HProc := GetProcAddress(HLib,'GPEncryptStream');
          if @HProc <> nil then
          HProc(PChar(TxtPWd.Text),
            TGPCipherAlgorithm(cbxCipher.Items.Objects[cbxCipher.ItemIndex]),
            TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
            Strm,Strm2,DoProgress);
          FreeLibrary(HLib);
        end;
      end;

    Strm2.Position := 0;
    (Strm2 as TMemoryStream).SaveToFile(AFileEncrypt);
  finally
    Strm.Free;
    Strm2.Free;
  end;
  StrmEncryptMsg.Caption := Format('Ok, %s file was successfully encoded, and saved under the name: %s (see on disk)',
    [ExtractFileName(AFile),ExtractFileName(AFileEncrypt)]);
  ProgressBar1.Position := 0;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  Strm,Strm2:TStream;
  AFile,AFileDecrypt:String;
begin
  ProgressBar1.Position := 0;
  Strm := TMemoryStream.Create;
  Strm2 := TMemoryStream.Create;
  try
    AFile := ChangeFileExt(StrmFile.Text,'')+ExtractFileExt(StrmFile.Text);
    AFileDecrypt := ChangeFileExt(StrmFile.Text,'.dec')+ExtractFileExt(StrmFile.Text);
    (Strm as TMemoryStream).LoadFromFile(AFile);
    Strm.Position := 0;
    FWrap.DecryptStream(PChar(TxtPWd.Text),
      TGPCipherAlgorithm(cbxCipher.Items.Objects[cbxCipher.ItemIndex]),
      TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
      TGPFormat(cbxFormat.Items.Objects[cbxFormat.ItemIndex]),Strm,Strm2);
    Strm2.Position := 0;
    (Strm2 as TMemoryStream).SaveToFile(AFileDecrypt);
  finally
    Strm.Free;
    Strm2.Free;
  end;
  StrmEncryptMsg.Caption := Format('Ok, %s file was successfully decoded, and saved under the name: %s (see on disk)',
    [ExtractFileName(AFile),ExtractFileName(AFileDecrypt)]);
  ProgressBar1.Position := 0;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TxtEncrypt.Text := FWrap.Sign(TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
    TGPFormat(cbxFormat.Items.Objects[cbxFormat.ItemIndex]),
    PChar(TxtSource.Text));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if FWrap.SignVerify(TGPHashType(cbxHash.Items.Objects[cbxHash.ItemIndex]),
    TGPFormat(cbxFormat.Items.Objects[cbxFormat.ItemIndex]),
    PChar(TxtSource.Text),
    PChar(TxtEncrypt.Text)) then TxtEncrypt.Text := 'Sign is valid'
  else TxtEncrypt.Text := 'Sign is invalid';
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do begin
    Filter := 'All files(*.*)|*.*';
    if Execute then StrmFile.Text := Filename;
    Free;
  end;
end;

end.
