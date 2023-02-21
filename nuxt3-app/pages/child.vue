<template>
  <div>{{ data }}</div>
</template>

<script>
export default{
  props:{
    data:{
       type: Object,
       required: true
    },
  setup(props){
    console.log(props);
  }
 }
}
</script>
