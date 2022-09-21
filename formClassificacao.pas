unit formClassificacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, dmClassificacao, 
  Conexao, Utilitario, Data.DB,  Vcl.WinXPanels,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, FormCadastroPadrao, Vcl.DBCtrls,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmClassificacao = class(TForm)
    ImageList1: TImageList;
    cardPrincipal: TCardPanel;
    cardPesquisa: TCard;
    cardClassificacao: TCard;
    pnAll: TPanel;
    lbDescricao: TLabel;
    pnEsquerda: TPanel;
    Image1: TImage;
    dtNomeClassificacao: TLabeledEdit;
    btSalvar: TButton;
    btCancelar: TButton;
    mmDescricao: TMemo;
    pnAllCenter: TPanel;
    pnBotton: TPanel;
    pnTop: TPanel;
    DBGrid1: TDBGrid;
    dtPesquisaClassificacao: TLabeledEdit;
    Button1: TButton;
    btAdicionar: TButton;
    btAlterar: TButton;
    btExcluir: TButton;
    btFechar: TButton;
    btRefresh: TButton;
    DataSource1: TDataSource;
    procedure btCancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure limparCampos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClassificacao: TfrmClassificacao;

implementation

uses
  udmCaixa;

{$R *.dfm}

procedure TfrmClassificacao.btAlterarClick(Sender: TObject);
begin
  
   dtClassificacao.cdsClassificacao.Edit;

   dtNomeClassificacao.Text := dtClassificacao.cdsClassificacaoNome.AsString;
   mmDescricao.Text :=      dtClassificacao.cdsClassificacaoDescricao.AsString;

   

   cardPrincipal.ActiveCard := cardClassificacao;
end;

procedure TfrmClassificacao.limparCampos;
var
  Contador: Integer;
begin
  for Contador := 0 to Pred(ComponentCount) do
  begin
    if Components[Contador] is TCustomEdit then
      TCustomEdit(Components[Contador]).Clear;
  end;
end;

procedure TfrmClassificacao.btCancelarClick(Sender: TObject);
begin
      dtClassificacao.cdsClassificacao.Cancel;    
      cardPrincipal.ActiveCard := cardPesquisa;
      
end;

procedure TfrmClassificacao.btExcluirClick(Sender: TObject);
begin
       if Application.MessageBox('Deseja Excluir a Classificação?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

    try
      dtClassificacao.cdsClassificacao.Delete;
        dtClassificacao.cdsClassificacao.applyUpdates(0);
        Application.MessageBox('Registro Excluido!', 'Atenção', MB_OK + MB_ICONINFORMATION );
       except on E : Exception do 
          Application.MessageBox(PWideChar(E.Message), 'Erro ao Excluir', MB_OK + MB_ICONERROR );   
    
    end;
end;

procedure TfrmClassificacao.btSalvarClick(Sender: TObject);
 var
 nomeClassificacao : String;

begin  
     nomeClassificacao :=  dtClassificacao.cdsClassificacaoNOME.AsString;  

     if DataSource1.State in [dsEdit] then
     begin 
       
       DataModule3.SQLCaixa.Open;
       DataModule3.SQLCaixa.Edit;
             
       DataModule3.SQLCaixa
       .ExecSQL('UPDATE CAIXA SET CLASSIFICACAO = ' +
       '''' +dtNomeClassificacao.Text +''''
        + 'WHERE CLASSIFICACAO =' +'''' +nomeClassificacao+'''' );
     
       DataModule3.SQLCaixa.Close;
       
     end;
    
     
     if DataSource1.State in [dsInsert] then
       begin
            dtClassificacao.cdsClassificacaoID.asString := TUtilitario.getId;
            
            
             
       end;  

          
    dtClassificacao.cdsClassificacaoNOME.AsString := Trim(dtNomeClassificacao.text); 
    dtClassificacao.cdsClassificacaoDESCRICAO.AsString := Trim(mmDescricao.Text); 

    dtClassificacao.cdsClassificacao.Post;
      
    dtClassificacao.cdsClassificacao.ApplyUpdates(0);       
    Application.MessageBox(PWideChar('Concluido com sucesso!'), 'Atenção', MB_OK + MB_ICONINFORMATION);
    
     cardPrincipal.ActiveCard := cardPesquisa;
end;

procedure TfrmClassificacao.Button1Click(Sender: TObject);
var 
FiltroPesquisa : String;
begin
     dtClassificacao.cdsClassificacao.close; 
     FiltroPesquisa := TUtilitario.LikeFind(dtPesquisaClassificacao.Text, DbGrid1);
     dtClassificacao.cdsClassificacao.CommandText := 'SELECT * FROM CLASSIFICACAO WHERE 1 = 1 ' +FiltroPesquisa;
     dtClassificacao.cdsClassificacao.Open; 
          

end;

procedure TfrmClassificacao.btAdicionarClick(Sender: TObject);
begin
    limparCampos;     
    dtClassificacao.cdsClassificacao.Insert;
    cardPrincipal.ActiveCard := cardClassificacao;
 
   
    
end;

procedure TfrmClassificacao.btFecharClick(Sender: TObject);
begin
   frmClassificacao.Close;
end;

procedure TfrmClassificacao.btRefreshClick(Sender: TObject);
begin
    dtClassificacao.cdsClassificacao.close;
    dtClassificacao.cdsClassificacao.CommandText := 'SELECT * FROM CLASSIFICACAO';
    dtClassificacao.cdsClassificacao.Open;
end;

procedure TfrmClassificacao.FormCreate(Sender: TObject);
begin 

   
   btRefreshClick(Sender);
     
   cardPrincipal.ActiveCard := cardPesquisa;
end;

end.
