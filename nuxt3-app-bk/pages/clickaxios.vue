<!-- <template>
  <div class="d-flex justify-center">
   <v-btn color="primary" large @click="getShops">shop一覧</v-btn>
   <div v-for="shop in shops" :key="shop.id">
         {{ shop.name }}
       </div>
 </div>
 </template>

 <script lang="ts">
   setup() {
     let shops = [{ id: 1, name: "sss", tell: "fff" }]

     const getShops = () => {
       axios.get('http://127.0.0.1:8000/api/shops')
         .then((res: any) => {
           if (res.status == 200) {
             shops = res.data
           }
         })
         .catch((error: any) => {
         });
     }
   }
 </script> -->