{ Guard Privacy Library
  Version 1.3.0.7

  Copyright © 1997-2009 by Richen, Maxim Kirichenko
  Last change: 03 November 2009

 THIS SOFTWARE IS PROVIDED BY THE AUTHORS "AS IS" AND ANY EXPRESS
 OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}
unit GP_Intrf;

interface
uses
  Classes;
const
  GP_EXIT_OK = 0;
  GP_EXIT_ERR_LIB   = 1;
  GP_EXIT_ERR_OTHER = 2;
type
  { Suppoterd ciphers }
  TGPCipherAlgorithm = (caBlowfish,caTwofish,caIDEA,caCast128,caCast256,caRC2,
    caRC4,caRC5,caRC6,caRijndael,caSquare,caSCOP,caSapphire,caGost,caTEA,caTEAN);
  { Supported hashes}	
  TGPHashType = (htMD4,htMD5,htSHA,htSHA256,htSHA512,htSapphire,hRipeMD128,
    htRipeMD256,htHaval128,htHaval256,htWhirlpool,htSquare,htSnefru128,htSnefru256);
  { Supported conversion algorithm }	
  TGPFormat = (fHex,fMime32,fMime64,fPGP);

  TGPNotify_Progress = procedure (const Min,Max,Position: Int64);

  ILibBase = interface
    function GetObject: TObject;
  end;
  
  ILibGP = interface(ILibBase)
  ['{EAC1DE3F-F676-4D77-AFEC-20C2FC886F28}']
    { random str }
    procedure RandomStr(var Buffer:PChar;Size:Integer);
	  {	Equivalent to the function GPRandomStr
		  Buffer		-	PChar, return variables, which will be recorded result of generation;
		  Size		-	Integer, string-length;
	  }

    { encrypt & decrypt text }
    function EncryptText(const AText,APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; AFormat:TGPFormat; var ATextOut:PChar):Integer;
	  {	Equivalent to the function GPEncryptText
		  AText		-	PChar, source text for encrypting;
		  APassword	-	PChar, password for encrypting;
		  ACipher		-	TGPCipherAlgorithm, cipher algorithm for encrypting;
		  AHash		-	TGPHashType, hash type for encrypting;
		  AFormat		-	TGPFormat, conversion algorithm, to convert the result of coding;
		  ATextOut	-	PChar, return variables, which will be recorded result of coding;
	  }
    function DecryptText(const AText,APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; AFormat:TGPFormat; var ATextOut:PChar):Integer;
	  {	Equivalent to the function GPDecryptText
		  AText		-	PChar, source text for encrypting;
		  APassword	-	PChar, password for encrypting;
		  ACipher		-	TGPCipherAlgorithm, cipher algorithm for encrypting;
		  AHash		-	TGPHashType, hash type for encrypting;
		  AFormat		-	TGPFormat, conversion algorithm, to convert the result of coding;
		  ATextOut	-	PChar, return variables, which will be recorded result of coding;
	  }

    { encrypt & decrypt stream }
    function EncryptStream(const APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; const ASource, ADest: TStream;
      const OnProgress: TGPNotify_Progress = nil):Integer;
	  {	Equivalent to the function GPEncryptStream
		  APassword	-	PChar, password for encrypting;
		  ACipher		-	TGPCipherAlgorithm, cipher algorithm for encrypting;
		  AHash		-	TGPHashType, hash type for encrypting;
		  ASource		-	TStream, source data for encrypting;
		  ADest		-	TStream, here to store the result coding;
		  OnProgress	-	TGPNotify_Progress, pointer on procedure "Progress";
	  }
	
    function DecryptStream(const APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; const ASource, ADest: TStream;
      const OnProgress: TGPNotify_Progress = nil):Integer;
	  {	Equivalent to the function GPDecryptStream
		  APassword	-	PChar, password for encrypting;
		  ACipher		-	TGPCipherAlgorithm, cipher algorithm for decrypting;
		  AHash		-	TGPHashType, hash type for decrypting;
		  ASource		-	TStream, source data for decrypting;
		  ADest		-	TStream, here to store the result coding;
		  OnProgress	-	TGPNotify_Progress, pointer on procedure "Progress";
	  }

    { encrypt & decrypt file}
    function EncryptFile(const APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; const ASource, ADest: PChar;
      const OnProgress: TGPNotify_Progress = nil):Integer;
	  {	Equivalent to the function GPEncryptFile
		  APassword	-	PChar, password for encrypting;
		  ACipher		-	TGPCipherAlgorithm, cipher algorithm for encrypting;
		  AHash		-	TGPHashType, hash type for encrypting;
		  ASource		-	PChar, path to source data for encrypting;
		  ADest		-	PChar, path to file to store the result coding;
		  OnProgress	-	TGPNotify_Progress, pointer on procedure "Progress";
	  }
    function DecryptFile(const APassword: PChar; const ACipher:TGPCipherAlgorithm;
      AHash: TGPHashType; const Source, Dest: PChar;
      const OnProgress: TGPNotify_Progress = nil):Integer;
	  {	Equivalent to the function GPDecryptFile
		  APassword	-	PChar, password for decrypting;
		  ACipher		-	TGPCipherAlgorithm, cipher algorithm for decrypting;
		  AHash		-	TGPHashType, hash type for decrypting;
		  ASource		-	PChar, path to source data for decrypting;
		  ADest		-	PChar, path to file to store the result coding;
		  OnProgress	-	TGPNotify_Progress, pointer on procedure "Progress";
	  }

    { sign }
    function Sign(const AHash: TGPHashType; const AFormat:TGPFormat;
      const ASource: PChar):PChar;
	  {	Equivalent to the function GPSign
		  AHash		-	TGPHashType, hash type for signature;
		  AFormat		-	TGPFormat, conversion algorithm, to convert the result of signature;
		  ASource		-	PChar, source data for the signature;
	  }

    function SignVerify(const AHash: TGPHashType; const AFormat:TGPFormat;
      const ASource,ASourceSign: PChar):Boolean;
	  {	Equivalent to the function GPSignVerify
		  AHash		-	TGPHashType, hash type for signature;
		  AFormat		-	TGPFormat, conversion algorithm, to convert the result of signature;
		  ASource		-	PChar, source data for the signature;
		  ASourceSing	-	PChar, verifies the signature;
	  }
  end;

  TLibBase = class(TInterfacedObject, ILibBase)
    function GetObject: TObject;
  end;
implementation

{ TLibBase }

function TLibBase.GetObject: TObject;
begin
  Result := Self;
end;

end.
