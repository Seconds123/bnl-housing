<script lang="ts">
	import Icon from "@iconify/svelte";
	import { createEventDispatcher, onMount } from "svelte";

	export let toggled = false;
	export let icon = "fa6-solid:check";
	export let tooltip = "";

	const dispatch = createEventDispatcher();

	const toggle = () => {
		toggled = !toggled;
		dispatch("toggled", { toggled: toggled });
	};

	onMount(() => {
		if (toggled) dispatch("toggled", { toggled: toggled });
	});
</script>

<button
	class="text-white group relative w-full rounded-md aspect-square grid place-items-center hover:shadow-sm transition-all outline-none {toggled
		? 'bg-blue-500'
		: 'bg-gray-400/25'}"
	on:click={toggle}
>
	<div
		class:opacity-100={toggled}
		class="text-2xl pointer-events-none opacity-0 transition-all {$$props.class}"
	>
		<Icon {icon} />
	</div>

	{#if tooltip}
		<div
			class="hidden group-hover:block absolute left-[100%] ml-4 p-1 px-2 rounded-md bg-black/95 text-white whitespace-nowrap"
		>
			{@html tooltip}
		</div>
	{/if}
</button>
