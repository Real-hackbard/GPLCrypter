unit GP_Wrapper;

interface
uses
  GP_Intrf, Windows, Classes, SysUtils;
type
  TLibGPWrapper = class(TLibBase,ILibBase)
  private
    FLib:ILibGP;
    FLibHandle: THandle;
  public
    constructor Create(const lib:string);
    destructor Destroy; override;
    function RandomStr(Size:Integer = 16):String;
    function EncryptText(const AText,APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; AFormat:TGPFormat; var ATextOut:PChar):Boolean;
    function DecryptText(const AText,APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; AFormat:TGPFormat; var ATextOut:PChar):Boolean;

    function EncryptStream(const APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; AFormat:TGPFormat; const ASource, ADest: TStream):Boolean;
    function DecryptStream(const APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; AFormat:TGPFormat; const ASource, ADest: TStream):Boolean;

    function Sign(const AHash: TGPHashType; const AFormat:TGPFormat;
      const ASource: PChar):PChar;
    function SignVerify(const AHash: TGPHashType; const AFormat:TGPFormat;
      const ASource,ASourceSign: PChar):Boolean;
  end;
  procedure DoProgress(const Min,Max,Pos: Int64);
implementation

uses Main;

procedure DoProgress(const Min,Max,Pos: Int64);
begin
  {MessageBox(0,PChar(Format('Ñurrent position of coding: %d from %d',[pos,max])),'Demonstration of "OnProgress" proc',
    MB_OK+MB_ICONINFORMATION);}
  Form1.ProgressBar1.Max := max;
  Form1.ProgressBar1.Position := pos;
end;
{ TLibGPWrapper }

constructor TLibGPWrapper.Create(const lib: string);
var
  GetLib: procedure(out Obj);
begin
  inherited Create;
  if FileExists(lib) then begin
    FLibHandle := LoadLibrary(PChar(Lib));
    if FLibHandle > 0 then begin
      @GetLib := GetProcAddress(FLibHandle,'GPGetLib');
      GetLib(FLib);
    end;
  end;
end;

function TLibGPWrapper.DecryptStream(const APassword: PChar;
  const ACipher: TGPCipherAlgorithm; AHash: TGPHashType; AFormat: TGPFormat;
  const ASource, ADest: TStream): Boolean;
begin
  Result := FLib.DecryptStream(APassword,ACipher,AHash,ASource,ADest,DoProgress) = GP_EXIT_OK;
end;

function TLibGPWrapper.DecryptText(const AText, APassword: PChar;
  const ACipher: TGPCipherAlgorithm; AHash: TGPHashType; AFormat: TGPFormat;
  var ATextOut: PChar): Boolean;
begin
  Result := FLib.DecryptText(PChar(AText),PChar(APassword),ACipher,AHash,AFormat,ATextOut) = GP_EXIT_OK;
end;

destructor TLibGPWrapper.Destroy;
begin
  if FLib <> nil then FLib:=nil;
  FreeLibrary(FLibHandle);
  inherited;
end;

function TLibGPWrapper.EncryptStream(const APassword: PChar;
  const ACipher: TGPCipherAlgorithm; AHash: TGPHashType; AFormat: TGPFormat;
  const ASource, ADest: TStream): Boolean;
begin
  Result := FLib.EncryptStream(APassword,ACipher,AHash,ASource,ADest,DoProgress) = GP_EXIT_OK;
end;

function TLibGPWrapper.EncryptText(const AText, APassword: PChar;
  const ACipher: TGPCipherAlgorithm; AHash: TGPHashType; AFormat: TGPFormat;
  var ATextOut:PChar): Boolean;
begin
  Result := FLib.EncryptText(AText,APassword,ACipher,AHash,AFormat,ATextOut) = GP_EXIT_OK;
end;

function TLibGPWrapper.RandomStr(Size: Integer): String;
var
  Buffer:PChar;
begin
  Buffer := StrAlloc(Size+1);
  FLib.RandomStr(Buffer,Size);
  Result := Buffer;
  Result := Copy(Buffer,1,StrLen(Buffer));
  StrDispose(Buffer);
end;

function TLibGPWrapper.Sign(const AHash: TGPHashType;
  const AFormat:TGPFormat; const ASource: PChar): PChar;
begin
  Result := FLib.Sign(AHash,AFormat,ASource);
end;

function TLibGPWrapper.SignVerify(const AHash: TGPHashType;
  const AFormat: TGPFormat; const ASource, ASourceSign: PChar): Boolean;
begin
  Result := FLib.SignVerify(AHash,AFormat,ASource,ASourceSign);
end;

end.
