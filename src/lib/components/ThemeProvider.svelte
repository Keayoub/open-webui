<script>
  import { onMount } from 'svelte';
  import { theme } from '$lib/stores';

  let current = 'light';

  const apply = (t) => {
    if (t === 'dark') {
      document.documentElement.classList.add('theme-dark');
    } else {
      document.documentElement.classList.remove('theme-dark');
    }
    current = t;
    try { localStorage.setItem('theme', t); } catch(e){}
    theme.set(t);
  };

  onMount(() => {
    const stored = localStorage.getItem('theme');
    const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    const initial = stored || (prefersDark ? 'dark' : 'light');
    apply(initial);
    // Expose helper for legacy code
    window.applyTheme = () => apply(localStorage.getItem('theme') || initial);
  });
</script>

<div class="theme-provider">
  <slot {current}></slot>
</div>

<style>
  .theme-provider{ display: contents; }
</style>
