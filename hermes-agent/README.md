# Auriko provider plugin for Hermes Agent

Use [Auriko](https://auriko.ai) as your LLM provider in [Hermes Agent](https://hermes-agent.nousresearch.com). Access 120+ models from Anthropic, OpenAI, DeepSeek, Google, and more through a single API key.

## Install

Run the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/zxyaction/intg-smoke-test/main/hermes-agent/install.sh | bash
```

Or copy the files manually:

```bash
mkdir -p ~/.hermes/plugins/model-providers/auriko
curl -fsSL https://raw.githubusercontent.com/zxyaction/intg-smoke-test/main/hermes-agent/plugin/__init__.py -o ~/.hermes/plugins/model-providers/auriko/__init__.py
curl -fsSL https://raw.githubusercontent.com/zxyaction/intg-smoke-test/main/hermes-agent/plugin/plugin.yaml -o ~/.hermes/plugins/model-providers/auriko/plugin.yaml
```

## Configure

Set your API key:

```bash
export AURIKO_API_KEY="ak_live_..."
```

Run the model wizard and select Auriko:

```bash
hermes model
```

## Verify

```bash
hermes chat -q "Say exactly: setup-ok" -Q --model claude-haiku-4-5-20251001
```

## Full documentation

See the [Hermes Agent integration guide](https://docs.auriko.ai/integrations/hermes-agent) for model IDs, routing options, and troubleshooting.
