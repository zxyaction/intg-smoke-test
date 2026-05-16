"""Auriko provider profile for Hermes Agent."""

from typing import Any

from providers import register_provider
from providers.base import ProviderProfile


class AurikoProvider(ProviderProfile):
    """Auriko multi-LLM inference gateway — dynamic catalog + routing options."""

    def fetch_models(
        self,
        *,
        api_key: str | None = None,
        timeout: float = 3.0,
    ) -> list[str] | None:
        return super().fetch_models(api_key=api_key, timeout=timeout)

    def build_extra_body(
        self, *, session_id: str | None = None, **context: Any
    ) -> dict[str, Any]:
        gateway = context.get("gateway")
        if gateway and isinstance(gateway, dict):
            return {"gateway": gateway}
        return {}


auriko = AurikoProvider(
    name="auriko",
    aliases=("auriko-ai",),
    display_name="Auriko",
    description="Auriko — multi-LLM inference gateway",
    signup_url="https://auriko.ai/signup",
    env_vars=("AURIKO_API_KEY",),
    base_url="https://api.auriko.ai/v1",
    default_aux_model="claude-haiku-4-5-20251001",
    fallback_models=(
        "claude-opus-4-7",
        "claude-opus-4-6",
        "claude-sonnet-4-6",
        "claude-haiku-4-5-20251001",
        "gpt-5.5-2026-04-23",
        "gpt-5.4-2026-03-05",
        "o4-mini-2025-04-16",
        "deepseek-v4-pro",
        "deepseek-v4-flash",
        "deepseek-v3.2",
        "gemini-2.5-pro",
        "gemini-2.5-flash",
        "gemini-3.1-pro-preview",
        "grok-4.3",
        "grok-4-fast-reasoning",
        "kimi-k2.6",
        "kimi-k2.5",
        "kimi-k2-thinking",
        "minimax-m2-7",
        "minimax-m2-7-highspeed",
        "minimax-m2",
        "glm-5.1",
        "glm-5",
        "glm-4.7",
        "glm-4.5-flash",
        "qwen-3.6-plus",
        "qwen-3.5-397b-a17b",
        "qwen-3-coder-480b-a35b-instruct-fp8",
        "qwen-3-vl-30b-a3b-thinking",
    ),
)

register_provider(auriko)
