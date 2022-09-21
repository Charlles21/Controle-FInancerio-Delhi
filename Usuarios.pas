unit Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Conexao, dmUsuarios, Vcl.Mask, Vcl.WinXCtrls, 
  Utilitario, Vcl.Imaging.pngimage, FormCadastroPadrao, System.Win.ComObj;
  

type
  TformUsuarios = class(TForm)
    cardPrincipal: TCardPanel;
    cardCadastro: TCard;
    cardPesquisa: TCard;
    ImageList1Usuario: TImageList;
    Panel1: TPanel;
    dtPesquisaUsuario: TEdit;
    btIncluir: TButton;
    btExel: TButton;
    btAlterar: TButton;
    btPesquisa: TButton;
    btRefresh: TButton;
    tggStatusUsuario: TToggleSwitch;
    dtUsuario: TDataSource;   
    btExcluir: TButton;
    DBGrid1: TDBGrid;
    dtLogin: TEdit;
    dtSenha: TEdit;
    dtNome: TEdit;
    lbStatus: TLabel;
    Panel2: TPanel;
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure LimparCampos();
    procedure btIncluirClick(Sender: TObject);    
    procedure btPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btPesquisaClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure dtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure dtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure tggStatusUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure btFecharClick(Sender: TObject);
    procedure btExelClick(Sender: TObject);
    
  private
    procedure validarCamposUsuario;
    procedure habilitarBotoes;
    procedure enterPress(var Key: Char);
    
    { Private declarations }
  public
    { Public declarations }
   
  protected 
  procedure Pesquisar; virtual;
  end;

var
  formUsuarios: TformUsuarios;

implementation 
  

{$R *.dfm}

procedure TformUsuarios.btAdicionarClick(Sender: TObject);
   Var 
   LStatus : String;
   Mensagem : String;
begin
 inherited;
 // muda o para o modo de ediçao!
  DataModule2.cdsUsuarios.Edit;
  validarCamposUsuario;

  if  DataModule2.temLoginCadastrado(Trim(dtLogin.Text), DataModule2.cdsUsuarios.FieldByName('ID').AsString) then
  begin
       dtSenha.SetFocus;
        Application.MessageBox(PWideChar(Format('O Login %s Ja se encontra cadastrado', [dtLogin.Text])), 'Erro ao Excluir', MB_OK + MB_ICONERROR );
        abort;
  end;      
    
    LStatus :='A';
 
    if tggStatusUsuario.State = tssOff then
     LStatus := 'B';

     Mensagem := 'Registro Alterado!';
           
    if DataModule2.cdsUsuarios.State in [dsInsert] then
      begin 
         Mensagem := 'Registro Incluido!';  
         DataModule2.cdsUsuariosid.AsString := TUtilitario.getId;
         DataModule2.cdsUsuariosdata_cadastro.AsDateTime := now;        
        
         
      end;
      
    DataModule2.cdsUsuarioslogin.AsString := Trim(dtLogin.Text);
    DataModule2.cdsUsuariosnome.AsString := Trim(dtNome.Text);
    DataModule2.cdsUsuariossenha.AsString := Trim(dtSenha.Text);
    DataModule2.cdsUsuariosstatus.AsString := LStatus;
    DataModule2.cdsUsuarios.Post;  
      
    DataModule2.cdsUsuarios.ApplyUpdates(0);       
    Application.MessageBox(PWideChar(Mensagem), 'Atenção', MB_OK + MB_ICONINFORMATION);

    
    cardPrincipal.ActiveCard := cardPesquisa;
     
end;

procedure TformUsuarios.btAlterarClick(Sender: TObject);
begin
  inherited;
    dmUsuarios.DataModule2.cdsUsuarios.Edit;
     
    dtLogin.Text := dmUsuarios.DataModule2.cdsUsuarioslogin.AsString;
    dtNome.Text := dmUsuarios.DataModule2.cdsUsuariosnome.AsString;
    dtSenha.Text := dmUsuarios.DataModule2.cdsUsuariossenha.AsString;
    tggStatusUsuario.State := tsson;

     if dmUsuarios.DataModule2.cdsUsuariosstatus.AsString = 'B' then
     begin
       tggStatusUsuario.State := tssoff;
     end;    

     cardPrincipal.ActiveCard := cardCadastro;
      
end;   



procedure TformUsuarios.btExcluirClick(Sender: TObject);
begin

   if Application.MessageBox('Deseja Excluir o Usuario?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

    try
      DataModule2.cdsUsuarios.Delete;
       DataModule2.cdsUsuarios.applyUpdates(0);
        Application.MessageBox('Registro Excluido!', 'Atenção', MB_OK + MB_ICONINFORMATION );
       except on E : Exception do 
          Application.MessageBox(PWideChar(E.Message), 'Erro ao Excluir', MB_OK + MB_ICONERROR );   
    
    end;
end;

procedure TformUsuarios.btFecharClick(Sender: TObject);
begin
  Usuarios.formUsuarios.Close;
end;

procedure TformUsuarios.btExelClick(Sender: TObject);
var
Planilha : Variant;
linha, contar : Integer; 

begin
     DataModule2.SQLUsuarios.Open;
     contar := DataModule2.cdsUsuarios.RecordCount;
     DataModule2.cdsUsuarios.Filtered := false;
     

     linha := 2;

     Planilha := createOleObject('Excel.Application');
     Planilha.Caption := 'Exportar dados';
     Planilha.Workbooks.add(1);

     Planilha.cells[1,1] := 'Nome';     
     Planilha.cells[1,2] := 'Login';
     Planilha.cells[1,3] := 'Status';
     
      DataModule2.SQLUsuarios.DisableControls;

     try
      while not DataModule2.cdsUsuarios.Eof do
          begin
            Planilha.cells[linha,1] := DataModule2.cdsUsuariosNome.value;
            Planilha.cells[linha,2] := DataModule2.cdsUsuariosLogin.value;
            Planilha.cells[linha,3] := DataModule2.cdsUsuariosStatus.value;
            DataModule2.cdsUsuarios.Next;
            linha := linha + 1;
          end;

         Planilha.Columns.autofit;
         Planilha.visible := true;
              
     
     finally
        DataModule2.cdsUsuarios.EnableControls;
        Planilha := unassigned;
     end;

end;

procedure TformUsuarios.btIncluirClick(Sender: TObject);
begin
  inherited;
            LimparCampos;            
            DataModule2.cdsUsuarios.Insert;
            cardPrincipal.ActiveCard := cardCadastro;
end;

procedure TformUsuarios.btPesquisaClick(Sender: TObject);
begin
 Pesquisar;
end;

procedure TformUsuarios.btPesquisarClick(Sender: TObject);
begin

  Pesquisar;
  inherited;

end;

procedure TformUsuarios.validarCamposUsuario;
begin


  if Trim(dtNome.Text) = '' then
  begin
    dtNome.SetFocus;
    Application.MessageBox('campo nao pode ser vazio', 'Atençao', MB_OK + MB_ICONWARNING);
     abort;
  end;
 
  if Trim(dtLogin.Text) = '' then
  begin
    dtNome.SetFocus;
    Application.MessageBox('campo nao pode ser vazio', 'Atençao', MB_OK + MB_ICONWARNING);
     abort;
  end;
 
  if Trim(dtSenha.Text) = '' then
  begin
    dtNome.SetFocus;
    Application.MessageBox('campo nao pode ser vazio', 'Atençao', MB_OK + MB_ICONWARNING);
    abort;
  end;
   
  
end;

procedure TformUsuarios.btRefreshClick(Sender: TObject);
begin
  inherited;
    dmUsuarios.DataModule2.cdsUsuarios.Close;   
    dmUsuarios.DataModule2.cdsUsuarios.CommandText :='Select * From usuarios';
    dmUsuarios.DataModule2.cdsUsuarios.Open;
end;

procedure TformUsuarios.Button1Click(Sender: TObject);
begin
        DataModule2.cdsUsuarios.Cancel;
        cardPrincipal.ActiveCard := cardPesquisa;
end;

procedure TformUsuarios.dtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  enterPress(Key);
end;

procedure TformUsuarios.dtNomeKeyPress(Sender: TObject; var Key: Char);
begin
   enterPress(Key);
end;

procedure TformUsuarios.dtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
     enterPress(Key);
end;

procedure TformUsuarios.FormActivate(Sender: TObject);
begin
    cardPrincipal.ActiveCard := cardPesquisa;
end;

procedure TformUsuarios.FormCreate(Sender: TObject);
begin
     btRefreshClick(Sender);
     cardPrincipal.ActiveCard := cardPesquisa;
     
end;

procedure TformUsuarios.FormShow(Sender: TObject);
begin
  inherited;    
      btRefreshClick(Sender);
      cardPrincipal.ActiveCard := cardPesquisa;
      
end;

procedure TformUsuarios.habilitarBotoes;
begin
     btExcluir.Enabled := not dtUsuario.DataSet.IsEmpty;
     btAlterar.Enabled := not dtUsuario.DataSet.IsEmpty;
     
end;

procedure TformUsuarios.LimparCampos;
 var 
     Contador : Integer;
begin
    for Contador := 0 to Pred(ComponentCount)  do
    begin
      if Components[Contador] is TCustomEdit then
         TCustomEdit(Components[Contador]).Clear

         
         else if Components[Contador] is TToggleSwitch then
           TToggleSwitch(Components[Contador]).State := tssOn;
    end;
    
           

end;

procedure TformUsuarios.Pesquisar;
  var
  FiltroPesquisa : String;
  

begin
    


    habilitarBotoes;
    FiltroPesquisa := TUtilitario.LikeFind(dtPesquisaUsuario.Text, DBGrid1);
    dmUsuarios.DataModule2.cdsUsuarios.Close;   
    dmUsuarios.DataModule2.cdsUsuarios.CommandText :='Select * From usuarios WHERE 1 = 1 '+ FiltroPesquisa;
    dmUsuarios.DataModule2.cdsUsuarios.Open;
end;

procedure TformUsuarios.tggStatusUsuarioKeyPress(Sender: TObject;
  var Key: Char);
begin
enterPress(Key);
end;

procedure TformUsuarios.enterPress(var Key: Char);
begin
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;

end;

end.
