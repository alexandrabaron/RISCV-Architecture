module cache #(
    localparam ByteOffsetBits = 4,
    localparam IndexBits = 6,
    localparam TagBits = 22,

    localparam NrWordsPerLine = 4,
    localparam NrLines = 64,

    localparam LineSize = 32 * NrWordsPerLine
) (
    input logic clk_i, //horloge
    input logic rstn_i, //reset

    input logic [31:0] addr_i, //adresse de la memoire a acceder

    // Read port
    input logic read_en_i, //signal de lecture
    output logic read_valid_o, 
    output logic [31:0] read_word_o,

    // Memory
    output logic [31:0] mem_addr_o,

    // Memory read port
    output logic mem_read_en_o,
    input logic mem_read_valid_i, //reponse de la memoire si MISS
    input logic [LineSize-1:0] mem_read_data_i //reponse de la memoire si MISS
);

    // **REGISTRES POUR LE CACHE** 
    logic [NrWordsPerLine-1:0][31:0] cache_data_way0 [NrLines];
    logic [NrWordsPerLine-1:0][31:0] cache_data_way1 [NrLines];
    logic [TagBits-1:0] cache_tag_way0 [NrLines];
    logic [TagBits-1:0] cache_tag_way1 [NrLines];
    logic cache_valid_way0 [NrLines];
    logic cache_valid_way1 [NrLines];
    logic lru [NrLines]; // 0 = voie 0 est LRU, 1 = voie 1 est LRU

    // Découpage de l'adresse
    logic [TagBits-1:0] tag;
    logic [IndexBits-1:0] index;
    logic [ByteOffsetBits-1:0] offset;

    assign tag = addr_i[31:32-TagBits];
    assign index = addr_i[32-TagBits-1:ByteOffsetBits];
    assign offset = addr_i[ByteOffsetBits-1:0];

    // Signaux de hit pour chaque voie
    logic hit_way0, hit_way1;
    assign hit_way0 = cache_valid_way0[index] && (cache_tag_way0[index] == tag);
    assign hit_way1 = cache_valid_way1[index] && (cache_tag_way1[index] == tag);

    // Signal global de hit
    logic hit;
    assign hit = hit_way0 || hit_way1;

    // Sélection de la voie à lire en cas de hit
    assign read_word_o = (hit_way0) ? cache_data_way0[index][offset] :
                         (hit_way1) ? cache_data_way1[index][offset] :
                         mem_read_data_i[offset*32 +: 32]; // En cas de miss, lire depuis la mémoire

    // Requête à la mémoire en cas de miss
    assign mem_addr_o = {tag, index, {ByteOffsetBits{1'b0}}};
    assign mem_read_en_o = !hit && read_en_i;

    // Déterminer la voie à évicter en cas de miss
    logic way_to_replace;
    assign way_to_replace = lru[index]; // 0 = voie 0, 1 = voie 1

    // Mise à jour du cache et du LRU
    always_ff @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            // Réinitialisation du cache et du LRU
            for (int i = 0; i < NrLines; i++) begin
                cache_valid_way0[i] <= 1'b0;
                cache_valid_way1[i] <= 1'b0;
                lru[i] <= 1'b0; // Initialement, la voie 0 est LRU
            end
        end else if (mem_read_valid_i) begin
            // Mise à jour du cache avec la nouvelle ligne
            if (way_to_replace == 1'b0) begin
                cache_data_way0[index] <= mem_read_data_i;
                cache_tag_way0[index] <= tag;
                cache_valid_way0[index] <= 1'b1;
            end else begin
                cache_data_way1[index] <= mem_read_data_i;
                cache_tag_way1[index] <= tag;
                cache_valid_way1[index] <= 1'b1;
            end
            // Mise à jour du LRU
            lru[index] <= ~way_to_replace; // La voie remplacée devient la plus récemment utilisée
        end else if (hit) begin
            // Mise à jour du LRU en cas de hit
            if (hit_way0) begin
                lru[index] <= 1'b1; // La voie 1 devient LRU
            end else if (hit_way1) begin
                lru[index] <= 1'b0; // La voie 0 devient LRU
            end
        end
    end

    // Signal de validité de la donnée lue
    assign read_valid_o = (hit && read_en_i) || mem_read_valid_i;

endmodule
