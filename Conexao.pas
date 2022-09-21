unit Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    SQL_CONEXAO: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
   
  private
    { Private declarations }
    const FILE_CONFIG = 'MonolitoFinanceiro.cfg';
  public
    { Public declarations }
    procedure carregarConfiguracoes;
    procedure Conectar;
    procedure Desconectar;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.carregarConfiguracoes;
 var
   ParametroNome : String;
   ParametroValor : String;
   Contador : Integer;
   ListParametro : TStringList;
begin
    SQL_CONEXAO.Params.Clear;
    if not FileExists(FILE_CONFIG) then
    raise Exception.Create('Arquivo configuraçao nao encontrado');
    ListParametro := TStringList.Create;

    try
      ListParametro.LoadFromFile(FILE_CONFIG);
      for Contador := 0 to Pred(ListParametro.Count) do
      
        begin
        
          if ListParametro[Contador].IndexOf('=') > 0 then
              begin
              
                ParametroNome := ListParametro[Contador].Split(['=']) [0].Trim;
                ParametroValor := ListParametro[Contador].Split(['=']) [1].Trim;
                SQL_CONEXAO.Params.Add(ParametroNome + '=' + ParametroValor);
                
              end;
        end;
        
    finally
        ListParametro.Free;
    end;
end;

procedure TDataModule1.Conectar;
begin
     SQL_CONEXAO.Connected;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
      carregarConfiguracoes;
      Conectar;
end;

procedure TDataModule1.Desconectar;
begin
     SQL_CONEXAO.Connected := False;
end;

end.
