
Figure()
for l in 2:4
for x in filter(x->length(x[2])==l,byPat)
plot(x[2],x[3],hold=true)
end
end
xlabel("Mois")
ylabel("βA40")
title("Béta-Amyloide-40 Pour Chaque Participant Avec Le Temps")

Figure()
for l in 2:4
for x in filter(x->length(x[2])==l,byPat)
plot(x[2],x[4],hold=true)
end
end
xlabel("Mois")
ylabel("βA42")
title("Béta-Amyloide-42 Pour Chaque Participant Avec Le Temps")

histogram(vcat(data.AB40...),xlim=(0,400),label="βA-40",hold=true)
histogram(vcat(data.AB42...),label="βA-42")
title("Répartition des Observations de Béta-Amyloide")
ylabel("Nombre des Observations")


histogram(vcat(data.AB42...) ./ vcat(data.AB40...))
title("Répartition des Observations Ratios de Béta-Amyloide 42/40")
ylabel("Nombre des Observations")
xlabel(" βA42 / βA40 ")

Figure()
plot(LinRange(1,372,372),E(D,5), ylim=(0,0.1), label="βA-40")
oplot(LinRange(1,103,103),E(D,6),label="βA-42")
title("Marginal Répartition de Béta-Amyloide")
ylabel("Probabilité")
xlabel("βA")
legend()
savefig("MarginalBA.png",gcf())

Figure()
plot(log.(1:372),E(D,5), ylim=(0,0.1), label="log(βA40)",hold=true)
plot(log.(1:103),E(D,6),label="log(βA42)")
title("Marginal Répartition de Logarithm de Béta-Amyloide")
ylabel("Probabilité")
xlabel("log(βA)")
legend()
savefig("MarginalLogBA.png",gcf())

Figure()
plot(0.01:0.01:1.34,E(Dr,5),label="r := βA42/βA40",hold=true)
plot(exp.(-1*(0.01:0.01:1.34)) .- (0.01:0.01:1.34),E(Dr,5),label="exp(r)-r")
plot(exp.(-1*(0.01:0.01:1.34)) .- 1,E(Dr,5),label="exp(r)-1")
title("Marginal Répartition des Ratios de Béta-Amyloide")
ylabel("Probabilité")
legend()
savefig("MarginalBAratios.png",gcf())

Figure()
plot(1:372,E(D,5) ./ 372,hold=true)
plot(1:103,E(D,6) ./ 103 )
title("Marginal Répartition de Logarithm de Béta-Amyloide")
ylabel("Probabilité")
xlabel("log(βA)")
legend()
savefig("MarginalLogBA.png",gcf())

Figure()
plot(E(D[:,:,2,:,:,:],4),label="AD",hold=true)
plot(E(D[:,2,1,:,:,:],3),label="MCI")
plot(E(D[2,1,1,:,:,:],2),label="NL")
title("Marginal Répartition de Béta-Amyloide-40 par Classement")
ylabel("Probabilité")
xlabel("βA40")
legend()
savefig("BA40byClass.png",gcf())

Figure()
plot(E(D[:,:,2,:,:,:],5),label="AD",hold=true)
plot(E(D[:,2,1,:,:,:],4),label="MCI")
plot(E(D[2,1,1,:,:,:],3),label="NL")
title("Marginal Répartition de Béta-Amyloide-42 par Classement")
ylabel("Probabilité")
xlabel("βA42")
legend()
savefig("BA42byClass.png",gcf())

Figure()
plot(E(Dr[:,:,2,:,:],4),label="AD",hold=true)
plot(E(Dr[:,2,1,:,:],3),label="MCI")
plot(E(Dr[2,1,1,:,:],2),label="NL")
title("Marginal Répartition de Béta-Amyloide-42/40 Ratio par Classement")
ylabel("Probabilité")
xlabel("βA42/βA40")
legend()
savefig("BAratiobyClass.png",gcf())

Figure()
plot(LinRange(1,372,372),permutedims(E(D,(4,5)),[2,1]) )
title("Répartition de Béta-Amyloide-40 dans le temps")
ylabel("Probabilité")
xlabel("βA40")
legend("0 mois","12 mois","24 mois", "36 mois")
savefig("BA40byTime.png",gcf())


plot(LinRange(1,103,103),permutedims(E(D,(4,6)),[2,1]) )
title("Répartition de Béta-Amyloide-42 dans le temps")
ylabel("Probabilité")
xlabel("βA42")
legend("0 mois","12 mois","24 mois", "36 mois")
savefig("BA42byTime.png",gcf())

plot(LinRange(1,134,134),permutedims(E(Dr,(4,5)),[2,1]) )
title("Répartition de Béta-Amyloide-42/40 Ratio dans le temps")
ylabel("Probabilité")
xlabel("βA42/βA40")
legend("0 mois","12 mois","24 mois", "36 mois")
savefig("BAratiobyTime.png",gcf())


surface(cov(Dr,3,5))
title("Covariance ")
surface(cov(Dr,4,5))


plot(log.(1:372),E(G,3),hold=true, label="βA42")
plot(log.(1:103),E(G,4), label="βA40")


plot( 0.01:0.01:1.34,E(Gr,3), label="βA42/βA40")





for t in 1:4
plot(LinRange(1,372,372),E(D[:,:,:,t,:,:],5),label= "$(12*t) mois", hold=true)
end

codons = collect(keys(countmap([s[i-2:i] for i in 3:3:length(s)])))
freqs = collect(values(countmap([s[i-2:i] for i in 3:3:length(s)])))

AVGratio = [ f[i] for i in 1:4, f in data.ABratio ]*ones(354)/354
AVG42 = [ f[i] for i in 1:4, f in data.AB42 ]*ones(354)/354
AVG40 = [ f[i] for i in 1:4, f in data.AB40 ]*ones(354)/354

[ g[i] for i in 1:4, g in F.(map(x->x-AVG40,data.AB40))]
plot([ real.(g)[i] for i in 1:4, g in F.(map(x->x-AVG40,data.AB40))])
plot([ imag.(g)[i] for i in 1:4, g in F.(map(x->x-AVG40,data.AB40))])

plot([ real.(g)[i] for i in 1:4, g in F.(map(x->x-AVG42,data.AB42))])
plot([ imag.(g)[i] for i in 1:4, g in F.(map(x->x-AVG42,data.AB42))])

plot([ real.(g)[i] for i in 1:4, g in F.(map(x->x-AVGratio,data.ABratio))])
plot([ imag.(g)[i] for i in 1:4, g in F.(map(x->x-AVGratio,data.ABratio))])