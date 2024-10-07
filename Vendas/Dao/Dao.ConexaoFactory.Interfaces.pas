unit Dao.ConexaoFactory.Interfaces;

interface

uses
  FireDAC.Comp.Client;

type
  IConexaoFactory = interface
   ['{B83B5298-D16F-4B22-A41D-2D620AD87FEA}']
    function GetConexao: TFDConnection;
  end;

  TConexaoFactory = class abstract(TInterfacedObject, IConexaoFactory)
  public
    function GetConexao: TFDConnection; virtual; abstract;
  end;

  TSQLServerConexaoFactory = class(TConexaoFactory)
  public
    function GetConexao: TFDConnection; override;
  end;

implementation
uses
  System.SysUtils;

{ TSQLServerConexaoFactory }

function TSQLServerConexaoFactory.GetConexao: TFDConnection;
begin
  try
  Result := TFDConnection.Create(nil);
  Result.DriverName := 'MSSQL';
  Result.Params.Add('Server=FULLSTACK\SQLEXPRESS');
  Result.Params.Add('Database=Vendas');
  Result.Params.Add('User_Name=sa');
  Result.Params.Add('Password=DevOps@19082703');
  Result.Connected := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Erro: %s', [E.Message]);
  end;
end;

end.
