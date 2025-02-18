//direct_cash.sv 

module cache #(
    localparam ByteOffsetBits = 4,
    localparam IndexBits = 6,
    localparam TagBits = 22,

    localparam NrWordsPerLine = 4,
    localparam NrLines = 64,

    localparam LineSize = 32 * NrWordsPerLine
) (
    input logic clk_i,
    input logic rstn_i,

    input logic [31:0] addr_i,

    // Read port
    input logic read_en_i,
    output logic read_valid_o, //super signal utile
    output logic [31:0] read_word_o,

    // Memory
    output logic [31:0] mem_addr_o,

    // Memory read port
    output logic mem_read_en_o,
    input logic mem_read_valid_i,
    input logic [LineSize-1:0] mem_read_data_i
);

// **REGISTRES POUR LE CACHE** 
// Tableau pour stocker les tags
    logic [NrWordsPerLine-1:0][31:0] cache_data [NrLines]; //données de chaque ligne
    logic [TagBits-1:0] cache_tag [NrLines]; //tags de chaque ligne
    logic cache_valid [NrLines]; //bits de validité
//découpage de l'adresse adr_i
    logic [TagBits-1:0] tag; //bits les + significatifs
    logic [IndexBits-1:0] index; //bits du milieu pour select la ligne de cache.
    logic [ByteOffsetBits-1:0] offset; //bits les - significatifs pour select le mot dans la ligne.

    assign tag = addr_i[31:32-TagBits];
    assign index = addr_i[32-TagBits-1:ByteOffsetBits];
    assign offset = addr_i[ByteOffsetBits-1:0];
//signal hit / miss : un hit se produit si la ligne de cache est valide et le tag stocké dans la ligne correspond au tag de l'adresse. 
    logic hit;
    assign hit = cache_valid[index] && (cache_tag[index] == tag); 
// si c'est un hit on renvoie le mot correspondant à l'offset dans la ligne de cache. 
    assign read_word_o = hit ? cache_data[index][offset] : mem_read_data_i[offset*32 +: 32]; //Si HIT alors la donnée est lue depuis le cache, si HIT est faux la donnée est lue depuis la mémoire normale.
    assign read_valid_o = (hit && read_en_i) || mem_read_valid_i; //determine si la donnee renvoyee est valide. 
//requete a la memoire si on a un MISS 
    assign mem_addr_o = {tag, index, {ByteOffsetBits{1'b0}}}; //adresse alignée sur la ligne
    assign mem_read_en_o = !hit && read_en_i; //activation de la lecture de mémoire

//Q8 transmission de la reponse de la mémoire cad si la memoire repond ( if (mem_read_valid_i) ) on stock la ligne dans le cache et on renvoie le mot demandé. 
    always_ff @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin //reinitialisation du cache
            for (int i = 0; i < NrLines; i++) begin
                cache_valid[i] <= 1'b0;
            end
        end else if (mem_read_valid_i) begin //maj du cache avec avec la nouvelle ligne
            cache_data[index] <= mem_read_data_i;
            cache_tag[index] <= tag;
            cache_valid[index] <= 1'b1;
        end
    end

endmodule
