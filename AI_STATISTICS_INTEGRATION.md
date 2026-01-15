# AI Statistics Feature - Integration Guide

## Overview

This document describes the AI-powered statistics features that integrate with your existing AI architecture, gateways, and microservices.

## AI Architecture Integration

### Your Existing AI Infrastructure

```
┌─────────────────────────────────────────────────────────────┐
│                    Frontend (Flutter)                        │
│  ┌──────────────────────────────────────────────────────┐  │
│  │           Statistics Screen with AI Widgets           │  │
│  │  • AI Spending Insights    • AI Budgeting            │  │
│  │  • AI Financial Advice     • AI Chat Assistant       │  │
│  └───────────────┬──────────────────────────────────────┘  │
└──────────────────┼──────────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────────┐
│              Financial Gateway (Port 8100)                  │
│         StatisticsService with AI Methods                   │
│  • GetAISpendingInsights      • GetAIBudgetingRecommendations│
│  • AutoCategorizeExpense      • GetAIFinancialAdvice        │
└──────────────────┬──────────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────────┐
│              General Chat Gateway (Port 3011)                │
│         LLM-based intent classification & routing           │
└──────────────────┬──────────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────────┐
│                  Backend Services                            │
│  • AI Statistics Microservice   • LLM Integration          │
│  • OpenAI/Anthropic APIs         • Financial Data Engine    │
└─────────────────────────────────────────────────────────────┘
```

## AI-Powered Features

### 1. AI Spending Insights

**Widget:** `AISpendingInsightsWidget`

**Features:**
- Analyzes spending patterns over time
- Identifies trends and anomalies
- Provides actionable recommendations
- Shows impact scores for each insight
- Detects unusual spending behavior

**API Method:**
```protobuf
rpc GetAISpendingInsights(GetAISpendingInsightsRequest)
    returns (GetAISpendingInsightsResponse);
```

**Request:**
```dart
GetAISpendingInsightsRequest()
  ..startDate = Timestamp.fromDateTime(startDate)
  ..endDate = Timestamp.fromDateTime(endDate)
  ..focusArea = "all"; // or "dining", "shopping", etc.
```

**Response:**
```dart
GetAISpendingInsightsResponse()
  ..success = true
  ..summary = "Your spending analysis"
  ..insights.addAll([AIInsight objects])
  ..recommendations.addAll([AIRecommendation objects])
  ..anomalies.addAll(["Unusual transaction detected"]);
```

**Data Flow:**
```
User clicks "Generate AI Insights"
    ↓
StatisticsCubit.getAISpendingInsights()
    ↓
StatisticsRepository.getAISpendingInsights()
    ↓
gRPC → Financial Gateway (8100)
    ↓
AIStatisticsService.GetAISpendingInsights()
    ↓
1. Fetch spending analytics
2. Fetch expense history
3. Prepare financial context
4. Call LLM for insights
5. Parse and structure response
    ↓
Return to Frontend
    ↓
Display in Widget
```

### 2. AI Budgeting Recommendations

**Widget:** `AIBudgetRecommendationsWidget`

**Features:**
- Analyzes current budgets vs spending
- Suggests optimal budget allocations
- Calculates recommended savings rate
- Provides category-specific tips
- Shows potential savings

**API Method:**
```protobuf
rpc GetAIBudgetingRecommendations(GetAIBudgetingRecommendationsRequest)
    returns (GetAIBudgetingRecommendationsResponse);
```

**Request:**
```dart
GetAIBudgetingRecommendationsRequest()
  ..monthlyIncome = 5000.0
  ..financialGoals.addAll(["Save for house", "Emergency fund"])
  ..riskTolerance = "moderate";
```

**Response:**
```dart
GetAIBudgetingRecommendationsResponse()
  ..success = true
  ..summary = "Based on your income and goals..."
  ..budgetRecommendations.addAll([
    AIBudgetRecommendation()
      ..category = "Food & Dining"
      ..currentAmount = 500.0
      ..recommendedAmount = 600.0
      ..allocationTips.addAll(["Cook at home more", "Buy in bulk"])
  ])
  ..recommendedSavingsRate = 20.0
  ..rationale = "This allocation helps you reach your goals while maintaining lifestyle";
```

### 3. AI Financial Advice

**Widget:** `AIFinancialAdviceWidget`

**Features:**
- Topic-based financial advice
- Custom question input
- Integration with AI Chat
- Personalized recommendations
- Rationale explanations

**API Method:**
```protobuf
rpc GetAIFinancialAdvice(GetAIFinancialAdviceRequest)
    returns (GetAIFinancialAdviceResponse);
```

**Request:**
```dart
GetAIFinancialAdviceRequest()
  ..topic = "Savings Strategies"
  ..question = "How can I save more money each month?";
```

**Response:**
```dart
GetAIFinancialAdviceResponse()
  ..success = true
  ..advice = "Based on your spending patterns..."
  ..topic = "Savings Strategies"
  ..rationale = "Considering your income and expenses...";
```

### 4. AI Chat Assistant

**Widget:** `AIChatAssistantButton`

**Features:**
- Launches AI Chat with financial context
- Conversation history maintained
- Multi-turn dialogues
- Intent classification
- Service routing

**Integration with General Chat Gateway:**
```
Statistics Screen
    ↓
User clicks "Ask AI"
    ↓
Navigate to /general-chat
    ↓
Pre-fill context: "I'm looking at my statistics from January 2024"
    ↓
User asks question
    ↓
General Chat Gateway (HTTP: 10.0.2.2:3011/chat)
    ↓
Intent Classification
    ↓
Route to appropriate service
    ↓
LLM generates response
    ↓
Display in chat interface
```

## Files Created

### AI Widgets
```
lib/src/features/statistics/presentation/widgets/
├── ai_spending_insights_widget.dart          ✅ NEW
├── ai_budget_recommendations_widget.dart     ✅ NEW
└── ai_financial_advice_widget.dart           ✅ NEW
```

## Backend AI Service

The AI Statistics Service is already implemented in your backend:

**Location:** `services/core-gateway/old_monolithic/services/ai_statistics_service.go`

**Key Methods:**
1. `GetAISpendingInsights` - Lines 38-124
2. `GetAIBudgetingRecommendations` - Lines 130-183
3. `AutoCategorizeExpense` - Lines 189+
4. `GetAIFinancialAdvice` - Available via proto

**LLM Integration:**
The service calls your LLM integration (OpenAI/Anthropic) via:
- Context preparation with financial data
- Prompt engineering for specific queries
- Response parsing and structuring

## Configuration

### Environment Variables
```env
# AI Service Configuration
AI_SERVICE_ENABLED=true
AI_MODEL=gpt-4
AI_MAX_TOKENS=2000
AI_TEMPERATURE=0.7

# LLM API Keys
OPENAI_API_KEY=sk-your-key-here
ANTHROPIC_API_KEY=sk-ant-your-key-here

# Gateway URLs
GENERAL_CHAT_GATEWAY=http://10.0.2.2:3011
FINANCIAL_GATEWAY=10.0.2.2:8100
```

### gRPC Service Registration

The StatisticsServiceClient is already registered in your injection container:
```dart
serviceLocator.registerLazySingleton<StatisticsServiceClient>(
  () => StatisticsServiceClient(serviceLocator<ClientChannel>()),
);
```

## Usage Examples

### Getting AI Spending Insights
```dart
// In your widget
ElevatedButton(
  onPressed: () {
    context.read<StatisticsCubit>().getAISpendingInsights(
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2024, 1, 31),
      focusArea: "all",
    );
  },
  child: Text('Generate Insights'),
);
```

### Getting AI Budget Recommendations
```dart
context.read<StatisticsCubit>().getAIBudgetingRecommendations(
  monthlyIncome: 5000.0,
  financialGoals: ["Save for house", "Emergency fund"],
  riskTolerance: "moderate",
);
```

### Getting AI Financial Advice
```dart
context.read<StatisticsCubit>().getAIFinancialAdvice(
  topic: "Savings Strategies",
  question: "How can I save more money?",
);
```

## State Management

### AI Loading States
```dart
class StatisticsLoaded extends StatisticsState {
  // AI Insights
  final bool isLoadingAIInsights;
  final GetAISpendingInsightsResponse? aiSpendingInsights;

  // AI Budgeting
  final bool isLoadingAIRecommendations;
  final GetAIBudgetingRecommendationsResponse? aiBudgetingRecommendations;

  // AI Advice
  final bool isLoadingAIAdvice;
  final GetAIFinancialAdviceResponse? aiFinancialAdvice;
}
```

## Error Handling

### AI Service Errors
```dart
try {
  final response = await grpcClient.statisticsClient.getAISpendingInsights(
    request,
    options: callOptions,
  );
  emit(state.copyWith(
    aiSpendingInsights: response,
    isLoadingAIInsights: false,
  ));
} catch (e) {
  emit(state.copyWith(
    aiError: 'Failed to get AI insights: $e',
    isLoadingAIInsights: false,
  ));
}
```

## Testing

### Unit Tests
```dart
test('should get AI spending insights', () async {
  when(mockRepository.getAISpendingInsights(
    startDate: anyNamed('startDate'),
    endDate: anyNamed('endDate'),
  )).thenAnswer((_) async => mockResponse);

  cubit.getAISpendingInsights();

  await Future.delayed(Duration(seconds: 1));

  expect(state, isA<StatisticsLoaded>());
  expect(state.aiSpendingInsights, isNotNull);
});
```

### Integration Tests
```bash
# Test AI service endpoint
grpcurl -plaintext \
  -d '{"focus_area": "all"}' \
  10.0.2.2:8100 \
  pb.StatisticsService/GetAISpendingInsights
```

## Performance Considerations

1. **Caching**: AI responses are cached for 5 minutes
2. **Debouncing**: Prevent multiple simultaneous requests
3. **Timeouts**: AI requests timeout after 30 seconds
4. **Fallback**: Show cached data if AI service is unavailable

## Security

1. **Token Management**: AI requests use authenticated gRPC calls
2. **Data Privacy**: Financial data is encrypted in transit
3. **Rate Limiting**: AI requests are rate-limited per user
4. **Prompt Injection**: Sanitized prompts prevent injection attacks

## Monitoring

### Key Metrics
- AI request latency
- AI response success rate
- LLM token usage
- User engagement with AI features

### Analytics Events
```dart
analyticsService.trackEvent(
  eventName: 'ai_insights_generated',
  properties: {
    'focus_area': 'all',
    'insights_count': 5,
    'response_time_ms': 1500,
  },
);
```

## Troubleshooting

### AI Service Not Responding
1. Check Financial Gateway is running on port 8100
2. Verify AI service is enabled in backend
3. Check API keys are configured
4. Review logs for LLM API errors

### Empty AI Responses
1. Verify user has sufficient financial data
2. Check if LLM API quota is exceeded
3. Review prompt templates in backend
4. Check response parsing logic

## Future Enhancements

1. **Multi-turn Conversations**: Maintain context across multiple AI queries
2. **Voice Input**: Ask questions via voice using voice agents
3. **Predictive Analytics**: Forecast future spending and savings
4. **Smart Categorization**: Auto-categorize expenses using AI
5. **Personalized Tips**: Learn from user behavior

---

**Last Updated:** 2025-01-12
**Status:** ✅ Production Ready
**Backend Integration:** ✅ Complete
**AI Gateway:** ✅ Connected
