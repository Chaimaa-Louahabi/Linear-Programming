#  1) G est une matrice dont le nombre de lignes et de colonnes est égal au nombre 
# de sommets du graphe
#  2) s est le sommmet source, on va caluler le plus court chemin entre s et tous 
# les autres sommets d’un graphe quelconque
# @return L : liste de taille = nombre de sommets de G, L(i) contient la 
# distance minimale ente s et le sommet i
function Algorithme_Bellman_Ford_court(G, s)
    # n : nombre de sommets
    n = size(G, 1)
    # tableau des distances depuis le sommet s
    L = zeros(n,1)
    Pred = zeros(n,1)
    arcs = get_arcs(G)
    for i = 1:n
        if i != s
            L[i] = Inf
        end
    end
    for k in 1:n
        for a in arcs
            if L[a[2]] > (L[a[1]] + G[a[1],a[2]])
                L[a[2]] = L[a[1]] + G[a[1],a[2]]
                Pred[a[2]] = a[1]
            end
        end
    end
    return L,Pred
end
#Calcul du plus long chemin
function Algorithme_Bellman_Ford_long(G, s)
    # n : nombre de sommets
    n = size(G, 1)
    # tableau des distances depuis le sommet s
    L = zeros(n,1)
    Pred = zeros(n,1)
    arcs = get_arcs(G)
    for i = 1:n
        if i != s
            L[i] = -Inf
        end
    end
    #println("L $L")
    for k in 1:n
        for a in arcs
            if L[a[2]] < (L[a[1]] + G[a[1],a[2]])
                L[a[2]] = L[a[1]] + G[a[1],a[2]]
                #println("L $L")
                Pred[a[2]] = a[1]
            end
        end
    end
    return L,Pred
end

function Algorithme_Bellman_Ford_vit_max(G, s)
    # n : nombre de sommets
    n = size(G, 1)
    # tableau des distances depuis le sommet s
    L = zeros(n,1)
    Pred = zeros(n,1)
    for i = 1:n
        if i != s
            L[i] = -Inf
        end
    end
    L[s] = Inf
    for k in 1:n
        for i in 2:n
            p = get_pred(G, i)
            for j in p
                if L[i] < min(L[j] , G[j,i])
                    L[i] = min(L[j] , G[j,i])
                    Pred[i] = j
                end
            end
        end
    end
    return L,Pred
end
# calcul du chemin le plus sûr
function Algorithme_Bellman_Ford_sur(G, s)
    # n : nombre de sommets
    n = size(G, 1)
    # tableau des distances depuis le sommet s
    L = zeros(n,1)
    Pred = zeros(n,1)
    L[1] = 1
    arcs = get_arcs(G)
    #println("L $L")
    for k in 1:n
        for a in arcs
            if L[a[2]] < (L[a[1]] * G[a[1],a[2]])
                L[a[2]] = L[a[1]] * G[a[1],a[2]]
                #println("L $L")
                Pred[a[2]] = a[1]
            end
        end
    end
    return L,Pred
end
#fonction auxiliaire qui retourne une liste de tuples, chaque tuple est un arc du graphe G
function get_arcs(G)
    u = []
    n = size(G,1)
    for i in 1:n
        for j in 1:n
            if G[i,j] != 0
                push!(u,(i,j))
            end
        end
    end
    return u
end
#fonction auxiliaire qui retourne une liste de predesseceurs de sommet i
function get_pred(G, i)
    u = []
    n = size(G,1)
    for j in 1:n
        if G[j,i] != 0
            push!(u,j)
        end
    end
    return u
end
function get_chemin(source, destination, noms, Pred)
    chemin = noms[destination]
    j = destination
    while Int(Pred[j]) != source
        k = Int(Pred[j])
        chemin  = string(noms[k]," -> ", chemin)
        j = k
    end
    chemin  = string(noms[source]," -> ", chemin)
end
