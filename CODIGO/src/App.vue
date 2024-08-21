<template>
  <div id="app">
    <DatabaseViewer />
  </div>
</template>

<script>
import DatabaseViewer from './components/DatabaseViewer.vue';

export default {
  name: 'App',
  components: {
    DatabaseViewer
  }
};
</script>

<style>
html, body {
  height: 100%;
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
  background-color: hsl(210, 93%, 48%);
  text-align: center;
}
</style>
