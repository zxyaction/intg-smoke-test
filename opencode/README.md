# Auriko provider for OpenCode

Use [Auriko](https://auriko.ai) as your LLM provider in [OpenCode](https://opencode.ai). Access models from Anthropic, OpenAI, DeepSeek, Google, and more through a single API key.

## Quick setup

Set your API key:

```bash
export AURIKO_API_KEY="ak_live_..."
```

Add Auriko as a provider in your `opencode.json` (at `~/.config/opencode/opencode.json` or in your project root):

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "auriko/claude-sonnet-4-6",
  "provider": {
    "auriko": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Auriko",
      "env": ["AURIKO_API_KEY"],
      "options": {
        "baseURL": "https://api.auriko.ai/v1",
        "apiKey": "{env:AURIKO_API_KEY}"
      },
      "models": {
        "claude-sonnet-4-6": {
          "name": "Claude Sonnet 4.6",
          "reasoning": true,
          "tool_call": true,
          "temperature": true,
          "limit": { "context": 1000000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        }
      }
    }
  }
}
```

Add more models by inserting entries in the `models` object. Model IDs must match what Auriko's `/v1/models` returns.

## Registry files

This directory also contains the [models.dev](https://models.dev) registry files:

- `provider.toml` — Auriko provider definition
- `models/*.toml` — Model capability definitions (29 models)
- `logo.svg` — Auriko logo for the registry

## Verify

```bash
opencode run "Say exactly: setup-ok" --model auriko/claude-sonnet-4-6 --pure
```

## Full documentation

See the [OpenCode integration guide](https://docs.auriko.ai/integrations/opencode) for all available models, routing options, and troubleshooting.
