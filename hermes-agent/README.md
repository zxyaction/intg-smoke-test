# Auriko Plugin for Hermes Agent

Use Auriko as your LLM provider in [Hermes Agent](https://hermes-agent.nousresearch.com).

## Prerequisites

- Hermes Agent 0.13.0+
- An [Auriko API key](https://auriko.ai/signup)

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/auriko-ai/integrations/main/hermes-agent/install.sh | bash
```

Then set your API key:

```bash
echo 'AURIKO_API_KEY=ak_live_...' >> ~/.hermes/.env
```

## Verify

```bash
hermes chat -q "Say exactly: setup-ok" -Q --model claude-haiku-4-5-20251001
```

## Full Documentation

See the [Hermes Agent integration guide](https://docs.auriko.ai/integrations/hermes-agent) for model selection, routing, and troubleshooting.
