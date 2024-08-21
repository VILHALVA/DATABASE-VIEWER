<template>
  <div class="container mt-5">
    <h2 class="text-center">DATABASE VIEWER</h2>
    <div class="form-group">
      <label for="file-upload" class="btn btn-primary">
        UPLOAD DE SQL/JSON
      </label>
      <input type="file" id="file-upload" @change="handleFileUpload" class="d-none" />
    </div>
    <div v-if="errorMessage" class="alert alert-danger">{{ errorMessage }}</div>
    <div v-if="tableData.length">
      <h4>Dados da Tabela:</h4>
      <table class="table table-dark">
        <thead>
          <tr>
            <th v-for="(value, key) in tableData[0]" :key="key">{{ key }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(row, index) in tableData" :key="index">
            <td v-for="(value, key) in row" :key="key">{{ value }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import '@/assets/styles.css';

export default {
  data() {
    return {
      tableData: [],
      errorMessage: ''
    };
  },
  methods: {
    handleFileUpload(event) {
      const file = event.target.files[0];
      const fileName = file.name.toLowerCase();

      if (fileName.endsWith('.sql')) {
        this.parseSQL(file);
      } 
      else if (fileName.endsWith('.json')) {
        this.parseJSON(file);
      } 
      else {
        this.errorMessage = 'Formato de arquivo não suportado. Por favor, envie um arquivo SQL ou JSON.';
      }
    },
    parseSQL(file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        try {
          const sql = e.target.result;
          this.tableData = this.extractInsertData(sql);
        } catch (error) {
          this.errorMessage = 'Erro ao processar o arquivo SQL.';
        }
      };
      reader.readAsText(file);
    },
    extractInsertData(sql) {
      const insertRegex = /INSERT INTO (\w+)\s*\(([^)]+)\)\s*VALUES\s*(.+?);/gis;
      const matches = [];
      let match;

      while ((match = insertRegex.exec(sql)) !== null) {
        const columns = match[2].split(',').map(col => col.trim());
        const valuesString = match[3];
        const values = valuesString
          .split(/\),\s*\(/)
          .map(valueString => valueString.replace(/[()]/g, '').split(',').map(val => val.trim().replace(/'/g, '')));

        values.forEach(valueArray => {
          let rowData = {};
          columns.forEach((col, i) => {
            rowData[col] = valueArray[i];
          });
          matches.push(rowData);
        });
      }

      if (matches.length > 0) {
        return matches;
      } 
      else {
        this.errorMessage = 'Erro ao processar o arquivo SQL.';
        return [];
      }
    },
    parseJSON(file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        try {
          const json = JSON.parse(e.target.result);
          this.tableData = Array.isArray(json) ? json : [json];
        } catch (error) {
          this.errorMessage = 'Erro ao processar o arquivo JSON.';
        }
      };
      reader.readAsText(file);
    }
  }
};
</script>
