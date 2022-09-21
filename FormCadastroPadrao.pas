unit FormCadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.WinXPanels, System.ImageList, Vcl.ImgList, 
  udmCaixa, Vcl.Mask, Vcl.Imaging.pngimage, Utilitario, Vcl.ComCtrls,
  Vcl.DBCtrls, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, dmClassificacao, System.Win.ComObj;

type
  TCaixa = class(TForm)
    cardPrincipal: TCardPanel;
    cardPesquisa: TCard;
    pnPesquisar: TPanel;
    pnBotoes: TPanel;
    pnGrid: TPanel;
    DBGrid1: TDBGrid;
    dtPesquisa: TEdit;
    lbPesquisa: TLabel;
    btPesquisar: TButton;
    btFechar: TButton;
    btIncluir: TButton;
    btAlterar: TButton;
    btExel: TButton;
    DataSource1: TDataSource;
    btRefreshCaixa: TButton;
    cardCaixa: TCard;
    pnEsquerda: TPanel;
    Image1: TImage;
    dtNumeroDoc: TLabeledEdit;
    dtValor: TLabeledEdit;
    rdTipoCaixa: TRadioGroup;
    lbDescricao: TLabel;
    btSalvar: TButton;
    ImageList1: TImageList;
    btCancelar: TButton;
    dtDescricao: TEdit;
    btExcluir: TButton;
    calendarCaixa: TMonthCalendar;
    cbTipo: TComboBox;
    lbTipo: TLabel;
    dbCombo: TDBLookupComboBox;
    cbPesquisaClassificacao: TDBLookupComboBox;
    ckHabilitaClassificacao: TCheckBox;
    dataInicio: TDateTimePicker;
    lbClassificacao: TLabel;
    dataFim: TDateTimePicker;
    ckDatasCaixa: TCheckBox;
    procedure btIncluirClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btRefreshCaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure dbComboClick(Sender: TObject);
    procedure ckHabilitaClassificacaoClick(Sender: TObject);
    procedure btExelClick(Sender: TObject);
    procedure cbPesquisaClassificacaoClick(Sender: TObject);
    procedure ckDatasCaixaClick(Sender: TObject);
    procedure dataFimChange(Sender: TObject);
  private
    { Private declarations }
    procedure habilitarBotoes;
    procedure validarCamposCaixa;
    
  public
    { Public declarations }

    protected 
    procedure pesquisar; virtual;
    public 
    procedure InserirNoBanco;
    procedure Limparcampos;
  end;

var
  Caixa: TCaixa;

implementation

uses
  Datasnap.DBClient, Vcl.WinXCtrls, formClassificacao, dmUsuarios;

{$R *.dfm}

procedure TCaixa.btAdicionarClick(Sender: TObject);
 

begin 

    InserirNoBanco;

    cardPrincipal.ActiveCard := cardPesquisa;

end;

procedure TCaixa.btAlterarClick(Sender: TObject);
begin
    DataModule3.cdsCaixa.Edit;
     
    dtNumeroDoc.Text := DataModule3.cdsCaixaNUMERO_DOC.AsString;
    dtValor.Text := DataModule3.cdsCaixaVALOR.AsString;
    dtDescricao.Text := DataModule3.cdsCaixaDESCRICAO.AsString;
    calendarCaixa.Date := DataModule3.cdsCaixaDATA_CADASTRO.AsDateTime;
    
    if DataModule3.cdsCaixaTIPO.AsString = 'R' then
       begin    
         rdTipoCaixa.ItemIndex := 0

      end
       else
       rdTipoCaixa.ItemIndex := 1;
    
    
    
    cardPrincipal.ActiveCard := cardCaixa;



end;

procedure TCaixa.btCancelarClick(Sender: TObject);
begin
    cardPrincipal.ActiveCard := cardPesquisa;
end;

procedure TCaixa.btExcluirClick(Sender: TObject);
begin

 if Application.MessageBox('Deseja Excluir?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

    try
      DataModule3.cdsCaixa.Delete;
      DataModule3.cdsCaixa.applyUpdates(0);
        Application.MessageBox('Item Excluido!', 'Atenção', MB_OK + MB_ICONINFORMATION );
       except on E : Exception do 
          Application.MessageBox(PWideChar(E.Message), 'Erro ao Excluir', MB_OK + MB_ICONERROR );   
    
    end;
end;

procedure TCaixa.btExelClick(Sender: TObject);
var
Planilha : Variant;
linha, contar : Integer;
begin
     DataModule3.SQLCaixa.Open;
     contar := DataModule2.cdsUsuarios.RecordCount;
     DataModule3.cdsCaixa.Filtered := false;
     

     linha := 2;

     Planilha := createOleObject('Excel.Application');
     Planilha.Caption := 'Exportar dados';
     Planilha.Workbooks.add(1);

     Planilha.cells[1,1] := 'numero Doc';     
     Planilha.cells[1,2] := 'Descrição';
     Planilha.cells[1,3] := 'valor';
     Planilha.cells[1,4] := 'tipo';
     Planilha.cells[1,5] := 'Data';
     Planilha.cells[1,6] := 'Classificação';
    
     
      DataModule3.cdsCaixa.DisableControls;

     try
      while not DataModule3.cdsCaixa.Eof do
          begin                        
            Planilha.cells[linha,1] := DataModule3.cdsCaixaNumero_doc.value;            
            Planilha.cells[linha,2] := DataModule3.cdsCaixaDescricao.value;
            Planilha.cells[linha,3] := DataModule3.cdsCaixaValor.asString;
            Planilha.cells[linha,4] := DataModule3.cdsCaixaTipo.value;
            Planilha.cells[linha,5] := DataModule3.cdsCaixaData_cadastro.value;
            Planilha.cells[linha,6] := DataModule3.cdsCaixaClassificacao.value;
            DataModule3.cdsCaixa.Next;
            linha := linha + 1;
          end;

         Planilha.Columns.autofit;
         Planilha.visible := true;
              
     
     finally
        DataModule3.cdsCaixa.EnableControls;
        Planilha := unassigned;
     end;

end;

procedure TCaixa.btFecharClick(Sender: TObject);
begin
   Caixa.Close;
end;

procedure TCaixa.btIncluirClick(Sender: TObject);
begin
      LimparCampos();
      calendarCaixa.Date := now;
      cardPrincipal.ActiveCard := cardCaixa;
      TClientDataset(DataSource1.DataSet).Insert;
      
end;

procedure TCaixa.btPesquisarClick(Sender: TObject);
var
FiltroPesquisa : String;
FiltroTipo : String;
FiltroClassificacao : String; 
begin 

    FiltroPesquisa  := TUtilitario.LikeFind(dtPesquisa.Text,DBGrid1);  

    if dataInicio.Date > dataFim.Date then
    begin
      raise Exception.Create('Periodo Invalido!');  
    end;
     
     
     case cbTipo.ItemIndex of
          1 : FiltroTipo := ' AND TIPO = ''R'' ';
          2 : FiltroTipo := ' AND TIPO = ''D'' '
     end;



     if cbPesquisaClassificacao.Enabled = true then
     begin          
      FiltroClassificacao := 'AND CLASSIFICACAO = ' + ''''+ cbPesquisaClassificacao.Text + '''';      
     end
     else
     begin
         FiltroClassificacao := '';         
     end;

     if ckDatasCaixa.Checked = true then
     begin       
      DataModule3.cdsCaixa.Close;  
      DataModule3.cdsCaixa.CommandText := 'Select * From Caixa where 1 = 1 '+ FiltroPesquisa +
      FiltroTipo + FiltroClassificacao + ' AND DATA_CADASTRO  BETWEEN :DATAINICIO AND :DATAFINAL'; 
            
      DataModule3.cdsCaixa.ParamByName('DATAINICIO').AsDate := dataInicio.Date;
      DataModule3.cdsCaixa.ParamByName('DATAFINAL').AsDate := dataFim.Date;
      
     end
     else
     Begin  
     DataModule3.cdsCaixa.Close;    
     DataModule3.cdsCaixa.CommandText := 'Select * From Caixa where 1 = 1 '+FiltroPesquisa +
     FiltroTipo + FiltroClassificacao;
     End;    
   
     
    
    
   
    DataModule3.cdsCaixa.Open; 
    
end;

procedure TCaixa.btRefreshCaixaClick(Sender: TObject);


begin
    DataModule3.cdsCaixa.Close;   
    DataModule3.cdsCaixa.CommandText :='Select * From Caixa';
    DataModule3.cdsCaixa.Open; 
end;

procedure TCaixa.btSalvarClick(Sender: TObject);
var
LTipo : String;
// R = Receita, D = Despesa
begin
  validarCamposCaixa;
  DataModule3.cdsCaixa.Edit;
  LTipo := 'R';

  
  if rdTipoCaixa.ItemIndex = 1 then
  begin
    LTipo := 'D';
  end;
 
                              
  if DataSource1.State in [dsInsert] then
  begin
   DataModule3.cdsCaixaID.asString := TUtilitario.getId;    
  end;


      
   DataModule3.cdsCaixaNUMERO_DOC.AsString := Trim(dtNumeroDoc.text);
   DataModule3.cdsCaixaDESCRICAO.AsString := Trim(dtDescricao.Text);
   DataModule3.cdsCaixaDATA_CADASTRO.AsDateTime := calendarCaixa.Date;
   DataModule3.cdsCaixaVALOR.AsCurrency := StrToFloat(dtValor.Text);
   DataModule3.cdsCaixaclassificacao.AsString := Trim(dbCombo.Text);
   
   DataModule3.cdsCaixaTIPO.AsString := LTipo;
   
   DataModule3.cdsCaixa.Post;     
   DataModule3.cdsCaixa.ApplyUpdates(0);
          
   Application.MessageBox(PWideChar('Concluido com sucesso!'), 'Atenção', MB_OK + MB_ICONINFORMATION);
    
   cardPrincipal.ActiveCard := cardPesquisa;
  

end;

procedure TCaixa.Button2Click(Sender: TObject);
begin
     DataModule3.cdsCaixa.Cancel;
     cardPrincipal.ActiveCard := cardPesquisa;
end;

procedure TCaixa.cbPesquisaClassificacaoClick(Sender: TObject);
begin
     btPesquisarClick(Sender);
end;

procedure TCaixa.cbTipoChange(Sender: TObject);
begin
    btPesquisarClick(Sender);
end;

procedure TCaixa.ckDatasCaixaClick(Sender: TObject);
begin
     if ckDatasCaixa.Checked = true then
     begin
       dataInicio.Enabled := true;
       dataFim.Enabled := true;
     end
     else 
     begin
       dataInicio.Enabled := false;
       dataFim.Enabled := false;
     end;
    
end;

procedure TCaixa.ckHabilitaClassificacaoClick(Sender: TObject);
begin
      if ckHabilitaClassificacao.Checked = true then
     begin          
      
      cbPesquisaClassificacao.Enabled := true;
     end
     else              
      cbPesquisaClassificacao.Enabled := false;
   
end;

procedure TCaixa.dataFimChange(Sender: TObject);
begin
 btPesquisarClick(Sender);
end;

procedure TCaixa.dbComboClick(Sender: TObject);
begin
  dtClassificacao.cdsClassificacao.Open;
end;

procedure TCaixa.FormActivate(Sender: TObject);
begin


dtClassificacao.cdsClassificacao.Open;
cardPrincipal.ActiveCard := cardPesquisa;


end;

procedure TCaixa.FormCreate(Sender: TObject);
begin
    
    btRefreshCaixaClick(Sender); 
    cardPrincipal.ActiveCard := cardPesquisa; 
end;

procedure TCaixa.FormShow(Sender: TObject);
begin
pesquisar;
end;

procedure TCaixa.habilitarBotoes;
begin

    
   
end;

procedure TCaixa.Limparcampos;
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

procedure TCaixa.validarCamposCaixa;
begin
  if Trim(dtValor.Text) = '' then
  begin
    dtValor.SetFocus;
    Application.MessageBox('Valor nao pode ser vazio ou nulo', 'Atençao', MB_OK + MB_ICONWARNING);
    abort;
  end;
  if rdTipoCaixa.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um tipo', 'Atençao', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TCaixa.InserirNoBanco;
var
  Mensagem: string;
begin
  //cast do do source to dataset
  if DataSource1.State in [dsInsert] then
    Mensagem := 'Concluido com sucesso!';
  TClientDataset(DataSource1.DataSet).Post;
  TClientDataset(DataSource1.DataSet).ApplyUpdates(0);
  Application.MessageBox(PWideChar(Mensagem), 'Atenção', MB_OK + MB_ICONINFORMATION);
end;

procedure TCaixa.pesquisar;
begin
    habilitarBotoes;
       
end;

end.
