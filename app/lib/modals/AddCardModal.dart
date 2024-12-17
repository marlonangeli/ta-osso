// lib/modals/add_card_modal.dart

import 'package:flutter/material.dart';
import 'package:ta_osso/common/constants/app_colors.dart';
import 'package:ta_osso/modals/AddAccountModal.dart';
import 'package:ta_osso/pages/select_icon_view.dart';
import 'package:ta_osso/models/CardModel.dart';
import 'package:ta_osso/services/card_service.dart';

void showAddCardModal(BuildContext context) {
  String? selectedIconPath;
  String selectedIconName = 'Selecione um banco';
  String? selectedAccountId;
  String selectedAccountTitle = 'Selecionar Conta';
  final TextEditingController nomeCartaoController = TextEditingController();
  final TextEditingController limiteController = TextEditingController();
  DateTime? fechamentoData;
  DateTime? vencimentoData;
  
  void _handleSave() async {
    try {
      // Validações
      if (selectedAccountId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione uma conta')),
        );
        return;
      }

      if (nomeCartaoController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite o nome do cartão')),
        );
        return;
      }

      if (limiteController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite o limite do cartão')),
        );
        return;
      }

      if (selectedIconPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione o ícone do cartão')),
        );
        return;
      }

      if (fechamentoData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione a data de fechamento')),
        );
        return;
      }

      if (vencimentoData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione a data de vencimento')),
        );
        return;
      }

      // Criar novo cartão
      final card = CardModel(
        id: '',
        name: nomeCartaoController.text,
        accountId: selectedAccountId!,
        limit: double.parse(limiteController.text.replaceAll(RegExp(r'[^0-9.]'), '')),
        iconPath: selectedIconPath!,
        bankName: selectedIconName,
        closingDay: fechamentoData!.day,
        dueDay: vencimentoData!.day,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final cardService = CardService();
      await cardService.createCard(card);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cartão criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar cartão: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, StateSetter setState) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Barra de arraste
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.timberwolf,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              
                const SizedBox(height: 16),
                const Text(
                  'Cadastro de Cartão',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.eerieBlack,
                  ),
                ),
              
                const SizedBox(height: 24),
                
                // Conta Pagamento
                const Text(
                  'Conta Pagamento',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.eerieBlack,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Botão Selecionar Conta
                InkWell(
                  onTap: () async {
                    final result = await showSelectAccountModal(context);
                    if (result != null) {
                      setState(() {
                        selectedAccountId = result['accountId'];
                        selectedAccountTitle = result['accountTitle'];
                        selectedIconPath = result['iconPath'];
                        selectedIconName = result['bankName'];
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.timberwolf),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        if (selectedIconPath != null) ...[
                          Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Image.asset(selectedIconPath!),
                          ),
                        ],
                        Expanded(
                          child: Text(
                            selectedAccountTitle,
                            style: TextStyle(
                              color: selectedAccountId != null 
                                  ? AppColors.eerieBlack 
                                  : AppColors.jet,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: AppColors.jet,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Ícone do Cartão
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.timberwolf),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: selectedIconPath != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                selectedIconPath!,
                                width: 24,
                                height: 24,
                              ),
                            )
                          : const Icon(Icons.credit_card, color: AppColors.jet),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SelectIconPage()),
                          );
                          
                          if (result != null && result is Map<String, String>) {
                            setState(() {
                              selectedIconPath = result['path'];
                              selectedIconName = result['name']!;
                            });
                          }
                        },
                        child: Text(
                          selectedIconPath != null ? selectedIconName : 'Escolher Ícone',
                          style: const TextStyle(
                            color: AppColors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Nome do Cartão
                TextField(
                  controller: nomeCartaoController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Cartão',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Limite Total
                TextField(
                  controller: limiteController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Limite Total',
                    prefixText: 'R\$ ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Datas de Fechamento e Vencimento
                Row(
                  children: [
                    // Data de Fechamento
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: fechamentoData ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() => fechamentoData = picked);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.timberwolf),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Fecha dia',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                fechamentoData != null
                                    ? fechamentoData!.day.toString()
                                    : 'Selecionar',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.eerieBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Data de Vencimento
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: vencimentoData ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() => vencimentoData = picked);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.timberwolf),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Vence dia',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                vencimentoData != null
                                    ? vencimentoData!.day.toString()
                                    : 'Selecionar',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.eerieBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Botão Salvar
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _handleSave,
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}