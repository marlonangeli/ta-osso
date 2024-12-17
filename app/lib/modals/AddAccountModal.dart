// lib/modals/add_account_modal.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ta_osso/common/constants/app_colors.dart';
import 'package:ta_osso/models/AccountModel.dart';
import 'package:ta_osso/pages/select_icon_view.dart';
import 'package:ta_osso/services/account_service.dart';

Future<Map<String, dynamic>?> showSelectAccountModal(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
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
            
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Selecionar Conta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.eerieBlack,
                ),
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('accounts')
                    .orderBy('title')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar contas'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma conta cadastrada'),
                    );
                  }

                  return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final data = doc.data() as Map<String, dynamic>;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.timberwolf),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context, {
                              'accountId': doc.id,
                              'accountTitle': data['title'],
                              'iconPath': data['iconPath'],
                              'bankName': data['bankName'],
                            });
                          },
                          leading: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              data['iconPath'],
                              width: 24,
                              height: 24,
                            ),
                          ),
                          title: Text(
                            data['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            data['bankName'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.jet,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



void showAddAccountModal(BuildContext context) {
  String? selectedIconPath;
  String selectedIconName = 'Selecione um banco';
  final TextEditingController tituloContaController = TextEditingController();
  final TextEditingController saldoInicialController = TextEditingController();

// No add_account_modal.dart, atualize o _handleSave:

  void _handleSave() async {
    try {
      // Validações
      if (tituloContaController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite o título da conta')),
        );
        return;
      }

      if (saldoInicialController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite o saldo inicial')),
        );
        return;
      }

      if (selectedIconPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione um ícone para a conta')),
        );
        return;
      }

      // Criar nova conta
      final account = AccountModel(
        id: '', // Será gerado pelo Firebase
        title: tituloContaController.text,
        initialBalance: double.parse(
            saldoInicialController.text.replaceAll(RegExp(r'[^0-9.]'), '')),
        iconPath: selectedIconPath!,
        bankName: selectedIconName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final accountService = AccountService();
      await accountService.createAccount(account);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar conta: $e'),
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
        initialChildSize: 0.70,
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
                  'Criar Nova Conta',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.eerieBlack,
                  ),
                ),

                const SizedBox(height: 24),

                // Ícone da Conta
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
                          : const Icon(Icons.account_balance,
                              color: AppColors.jet),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectIconPage()),
                          );

                          if (result != null && result is Map<String, String>) {
                            setState(() {
                              selectedIconPath = result['path'];
                              selectedIconName = result['name']!;
                            });
                          }
                        },
                        child: Text(
                          selectedIconPath != null
                              ? selectedIconName
                              : 'Escolher Ícone',
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

                // Título da Conta
                TextField(
                  controller: tituloContaController,
                  decoration: InputDecoration(
                    labelText: 'Título da Conta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 24),

                // Saldo Inicial
                TextField(
                  controller: saldoInicialController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Saldo Inicial',
                    prefixText: 'R\$ ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
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
