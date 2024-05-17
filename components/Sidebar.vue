<template>
    <aside >
        <ul class="menu gap-0 sm:gap-5  sidebar">
   
    
   <li class="tooltip tooltip-right" data-tip="Home">
       <NuxtLink to="/">
        <i class="fi fi-rr-home"></i>
       </NuxtLink>
   </li>
   <li class="tooltip tooltip-right" data-tip="Apps">
       <NuxtLink to="/apps">
        <i class="fi fi-rr-apps"></i>
       </NuxtLink>
   </li>
   <li class="tooltip tooltip-right" data-tip="Contact us">
       <NuxtLink to="/contact">
        <i class="fi fi-rr-envelope"></i>
       </NuxtLink>
   </li>
   <li class="tooltip tooltip-right" data-tip="About us">
       <NuxtLink to="/about">
        <i class="fi fi-rr-info"></i>
       </NuxtLink>
   </li>
</ul>
    </aside>
</template>

<script setup lang="ts"></script>
