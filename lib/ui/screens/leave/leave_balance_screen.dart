import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/leave_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';

class LeaveBalanceScreen extends StatefulWidget {
  const LeaveBalanceScreen({super.key});

  @override
  State<LeaveBalanceScreen> createState() => _LeaveBalanceScreenState();
}

class _LeaveBalanceScreenState extends State<LeaveBalanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch balances for all employees (admin view)
      // In a real app, you'd pass the current employee ID
      Provider.of<LeaveProvider>(context, listen: false).fetchLeaveBalances('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Leave Balances', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Consumer<LeaveProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.leaveBalances.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.leaveBalances.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet_outlined, size: 64, color: Colors.white.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No leave balances found',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Leave balances will appear here once configured',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.leaveBalances.length,
            itemBuilder: (context, index) {
              final balance = provider.leaveBalances[index];
              final available = balance.closingBalance;
              final total = balance.openingBalance + balance.accrued + balance.carryForward;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  balance.leaveType?.name ?? 'Unknown',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (balance.leaveType != null)
                                  Text(
                                    balance.leaveType!.code,
                                    style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5)),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                available.toStringAsFixed(available % 1 == 0 ? 0 : 1),
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: available > 0 ? const Color(0xFF22C55E) : Colors.redAccent,
                                ),
                              ),
                              Text(
                                'Available',
                                style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: total > 0 ? (balance.taken / total).clamp(0.0, 1.0) : 0,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            balance.taken / (total > 0 ? total : 1) > 0.8 ? Colors.redAccent : const Color(0xFF6366F1),
                          ),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Detail grid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBalanceDetail('Opening', balance.openingBalance, Colors.blue),
                          _buildBalanceDetail('Accrued', balance.accrued, Colors.teal),
                          _buildBalanceDetail('Taken', balance.taken, Colors.orange),
                          _buildBalanceDetail('Adjusted', balance.adjusted, Colors.purple),
                          _buildBalanceDetail('CF', balance.carryForward, Colors.cyan),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBalanceDetail(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          value.toStringAsFixed(value % 1 == 0 ? 0 : 1),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5)),
        ),
      ],
    );
  }
}
