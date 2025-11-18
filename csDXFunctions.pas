unit csDXFunctions;

interface

uses
  SysUtils,
  cxEditConsts, cxGridStrs, cxFilterControlStrs, cxFilterConsts,
  cxGridPopUpMenuConsts, cxClasses;

type

  { Dev Express Functions }
  TcsDXFunctions = class(TObject)
  public
    class procedure Translate_PTBR;
  end;

implementation

{ TcsDXFunctions }

class procedure TcsDXFunctions.Translate_PTBR;
begin

  //-- ComboBox de Data
  cxSetResourceString(@cxSDatePopupClear, 'Limpar');
  cxSetResourceString(@cxSDatePopupToday, 'Hoje');

  //-- cxGrid
  cxSetResourceString(@scxGridGroupByBoxCaption,'Agrupamento de colunas');
  cxSetResourceString(@scxGridNoDataInfoText,'<Nenhum Registro>');
  cxSetResourceString(@scxGridFilterCustomizeButtonCaption,'Customizar...');

  //--Componente de Filtro
  cxSetResourceString(@cxSFilterFooterAddCondition,'Adicionar nova condição');
  cxSetResourceString(@cxSFilterAddCondition,'Adicionar condição');
  cxSetResourceString(@cxSFilterAddGroup,'Adicionar grupo');
  cxSetResourceString(@cxSFilterRemoveRow,'Remover condição');
  cxSetResourceString(@cxSFilterClearAll,'Limpar filtros');
  cxSetResourceString(@cxSFilterErrorBuilding,'Não foi possível realizar o fitro');
  cxSetResourceString(@cxSFilterGroupCaption,'Aplicar as condições');
  cxSetResourceString(@cxSFilterControlDialogNewFile,'semtitulo.flt');

  cxSetResourceString(@cxSFilterRootButtonCaption,'Filtro');
  cxSetResourceString(@cxSFilterBoolOperatorAnd,'e');
  cxSetResourceString(@cxSFilterBoolOperatorNotAnd,'e não');
  cxSetResourceString(@cxSFilterBoolOperatorOr,'ou');
  cxSetResourceString(@cxSFilterBoolOperatorNotOr,'ou não');

  cxSetResourceString(@cxSFilterControlDialogActionApplyCaption,'Aplicar');
  cxSetResourceString(@cxSFilterControlDialogActionCancelCaption,'Cancelar');
  cxSetResourceString(@cxSFilterControlDialogActionOkCaption,'OK');

  cxSetResourceString(@cxSFilterControlDialogActionOpenCaption,'Abrir...');
  cxSetResourceString(@cxSFilterControlDialogActionSaveCaption,'Salvar Como...');

  cxSetResourceString(@cxSFilterControlDialogCaption,'Filtrar');
  cxSetResourceString(@cxSFilterControlDialogFileFilter,'Filtros');
  cxSetResourceString(@cxSFilterControlDialogOpenDialogCaption,'Abrir um filtro existente');
  cxSetResourceString(@cxSFilterControlDialogSaveDialogCaption,'Salvar o filtro atual para arquivo');

  cxSetResourceString(@cxSFilterControlNullString,'<Vazio>');
  cxSetResourceString(@cxSFilterDialogCaption,'Filtro customizado');
  cxSetResourceString(@cxSFilterDialogCharactersSeries,'Qualquer tipo de caractér');
  cxSetResourceString(@cxSFilterDialogInvalidValue,'Valor inválido!');

  cxSetResourceString(@cxSFilterDialogOperationAnd,'e');
  cxSetResourceString(@cxSFilterDialogOperationOr,'ou');

  cxSetResourceString(@cxSFilterDialogRows,'Mostrar as colunas aqui');
  cxSetResourceString(@cxSFilterDialogSingleCharacter,'Caractér único');
  cxSetResourceString(@cxSFilterDialogUse,'Usar');

  cxSetResourceString(@cxSFilterAndCaption,'e');
  cxSetResourceString(@cxSFilterBlankCaption,'nulo');
  cxSetResourceString(@cxSFilterBoxAllCaption,'todos');
  cxSetResourceString(@cxSFilterBoxBlanksCaption,'nulo');
  cxSetResourceString(@cxSFilterBoxCustomCaption,'customizar...');
  cxSetResourceString(@cxSFilterBoxNonBlanksCaption,'não nulo');
  cxSetResourceString(@cxSFilterNotCaption,'não');
  cxSetResourceString(@cxSFilterOperatorBeginsWith,'iniciar com');
  cxSetResourceString(@cxSFilterOperatorBetween,'entre');
  cxSetResourceString(@cxSFilterOperatorContains,'contendo');
  cxSetResourceString(@cxSFilterOperatorDoesNotBeginWith,'não começar com');
  cxSetResourceString(@cxSFilterOperatorDoesNotContain,'não contendo');
  cxSetResourceString(@cxSFilterOperatorDoesNotEndWith,'não terminar com');
  cxSetResourceString(@cxSFilterOperatorEndsWith,'terminar com');
  cxSetResourceString(@cxSFilterOperatorEqual,'igual');
  cxSetResourceString(@cxSFilterOperatorGreater	,'maior que');
  cxSetResourceString(@cxSFilterOperatorGreaterEqual,'maior ou igual que');
  cxSetResourceString(@cxSFilterOperatorInList,'estando em');
  cxSetResourceString(@cxSFilterOperatorIsNotNull,'não nulo');
  cxSetResourceString(@cxSFilterOperatorIsNull,'nulo');
  cxSetResourceString(@cxSFilterOperatorLastMonth,'mês anterior');
  cxSetResourceString(@cxSFilterOperatorLastWeek,'semana anterior');
  cxSetResourceString(@cxSFilterOperatorLastYear,'ano anterior');
  cxSetResourceString(@cxSFilterOperatorLess,'menor');
  cxSetResourceString(@cxSFilterOperatorLessEqual,'menor ou igual');
  cxSetResourceString(@cxSFilterOperatorLike,'contendo');
  cxSetResourceString(@cxSFilterOperatorNextMonth,'próximo mês');
  cxSetResourceString(@cxSFilterOperatorNextWeek,'próxima semana');
  cxSetResourceString(@cxSFilterOperatorNextYear,'próximo ano');
  cxSetResourceString(@cxSFilterOperatorNotBetween,'não entre');
  cxSetResourceString(@cxSFilterOperatorNotEqual,'diferente');
  cxSetResourceString(@cxSFilterOperatorNotInList,'não estando em');
  cxSetResourceString(@cxSFilterOperatorNotLike	,'não contendo');
  cxSetResourceString(@cxSFilterOperatorThisMonth,'neste mês');
  cxSetResourceString(@cxSFilterOperatorThisWeek,'nesta semana');
  cxSetResourceString(@cxSFilterOperatorThisYear,'neste ano');
  cxSetResourceString(@cxSFilterOperatorToday,'hoje');
  cxSetResourceString(@cxSFilterOperatorTomorrow,'amanhã');
  cxSetResourceString(@cxSFilterOperatorYesterday,'ontem');
  cxSetResourceString(@cxSFilterOrCaption,'ou');


  //-- Componente Pop-up Menu
  cxSetResourceString(@cxSGridAlignCenter,'Alinhar centralizado');
  cxSetResourceString(@cxSGridAlignLeft,'Alinhar à esquerda');
  cxSetResourceString(@cxSGridAlignRight,'Alinhar à direita');
  cxSetResourceString(@cxSGridAlignmentSubMenu,'Alinhamento');
  cxSetResourceString(@cxSGridAvgMenuItem,'Média');
  cxSetResourceString(@cxSGridBestFit,'Tamanho automático da coluna');
  cxSetResourceString(@cxSGridBestFitAllColumns,'Tamanho automático (Todas as colunas)');
  cxSetResourceString(@cxSGridCountMenuItem,'Contar');
  cxSetResourceString(@cxSGridFieldChooser,'Escolha de colunas');
  cxSetResourceString(@cxSGridGroupByBox,'Agrupamento de colunas');
  cxSetResourceString(@cxSGridGroupByThisField,'Agrupar por esta coluna');
  cxSetResourceString(@cxSGridMaxMenuItem,'Máximo');
  cxSetResourceString(@cxSGridMinMenuItem,'Mínimo');
  cxSetResourceString(@cxSGridNone,'Nenhum');
  cxSetResourceString(@cxSGridNoneMenuItem,'Nenhum');
  cxSetResourceString(@cxSGridRemoveColumn,'Remover esta coluna');
  cxSetResourceString(@cxSGridShowGroupFooter,'Rodapé agrupado');
  cxSetResourceString(@cxSGridSortColumnAsc,'Ordenação ascendente');
  cxSetResourceString(@cxSGridSortColumnDesc,'Ordenação descendente');
  cxSetResourceString(@cxSGridClearSorting,'Cancelar ordenação');
  cxSetResourceString(@cxSGridSumMenuItem,'Somar');
  cxSetResourceString(@cxSGridShowFooter,'Rodapé');

end;

end.
